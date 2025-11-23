(define (boxes-within-distance boxes max-boxes max-weight distance)
  (let loop ([i 0] [weight 0] [count 0])
    (cond
      [(>= i (length boxes)) (values count weight)]
      [(> (+ weight (vector-ref (list-ref boxes i) 1)) max-weight) (values count weight)]
      [(>= count max-boxes) (values count weight)]
      [else (loop (+ i 1) (+ weight (vector-ref (list-ref boxes i) 1)) (+ count 1))])))

(define (box-deliveries boxes ports max-boxes max-weight)
  (define n (length boxes))
  (define dp (make-vector (+ n 1) (add1 n))) ; Initialize with n+1

  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 i)])
      (let-values ([(count weight) (boxes-within-distance boxes max-boxes max-weight (- i j))])
        (when (= count (- i j))
          (let ([port-changes 0])
            (when (> (- i j) 0)
              (set! port-changes 1) ; First box always incurs a change
              (for ([k (in-range (+ j 1) i)])
                (when (not (= (vector-ref (list-ref boxes (- k 1)) 0) (vector-ref (list-ref boxes (- k) 0))))
                  (set! port-changes (+ port-changes 1)))))
            (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) port-changes 1))))))))

  (vector-ref dp n))

(define (deliver-boxes boxes ports max-boxes max-weight)
  (box-deliveries boxes ports max-boxes max-weight))