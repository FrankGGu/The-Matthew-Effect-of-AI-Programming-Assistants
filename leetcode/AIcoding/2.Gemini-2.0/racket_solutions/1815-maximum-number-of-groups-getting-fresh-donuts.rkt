(define (max-happy-groups batch-size groups)
  (let* ([counts (make-vector batch-size 0)]
         [happy (for/sum ([g (in-list groups)])
                  (modulo g batch-size))])
    (for ([g (in-list groups)])
      (vector-set! counts (modulo g batch-size) (+ 1 (vector-ref counts (modulo g batch-size)))))
    (let loop ([i 1] [happy-groups 0] [counts counts])
      (cond
        [(= i batch-size) happy-groups]
        [else
         (let* ([count-i (vector-ref counts i)]
                [needed (- batch-size i)])
           (cond
             [(zero? count-i) (loop (+ i 1) happy-groups counts)]
             [(vector-ref counts needed) (> 0) ]
             [(= i needed)
              (loop (+ i 1) (+ happy-groups (quotient count-i 2)) (vector-set! counts i (modulo count-i 2)))]
             [else
              (let* ([take (min (vector-ref counts i) (vector-ref counts needed))])
                (loop (+ i 1) (+ happy-groups take) (begin (vector-set! counts i (- (vector-ref counts i) take)) (vector-set! counts needed (- (vector-ref counts needed) take)) counts)))])
           ))])))

  (let* ([rem0 (vector-ref (for/vector ([g (in-list groups)]) (modulo g batch-size)) 0)]
         [other-groups (filter (lambda (g) (not (= (modulo g batch-size) 0))) groups)]
         [counts (make-vector batch-size 0)]
         [happy-groups rem0])
    (for ([g (in-list other-groups)])
      (vector-set! counts (modulo g batch-size) (+ 1 (vector-ref counts (modulo g batch-size)))))
    (let loop ([i 1] [happy-groups happy-groups] [counts counts])
      (cond
        [(= i batch-size) happy-groups]
        [else
         (let* ([count-i (vector-ref counts i)]
                [needed (- batch-size i)])
           (cond
             [(zero? count-i) (loop (+ i 1) happy-groups counts)]
             [(= i needed)
              (loop (+ i 1) (+ happy-groups (quotient count-i 2)) (vector-set! counts i (modulo count-i 2)))]
             [(vector-ref counts needed) (> 0) ]
             [else
              (let* ([take (min (vector-ref counts i) (vector-ref counts needed))])
                (loop (+ i 1) (+ happy-groups take) (begin (vector-set! counts i (- (vector-ref counts i) take)) (vector-set! counts needed (- (vector-ref counts needed) take)) counts)))])
           ))])))
  )