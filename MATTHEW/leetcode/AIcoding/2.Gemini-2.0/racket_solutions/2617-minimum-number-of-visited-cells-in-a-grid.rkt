(define (minimum-visited-cells grid)
  (let* ([m (length grid)]
         [n (length (car grid))]
         [dist (make-vector (* m n) #f)]
         [q (list 0)])
    (vector-set! dist 0 1)
    (define (index r c) (+ (* r n) c))
    (define (row-col idx) (values (quotient idx n) (remainder idx n)))

    (define (bfs)
      (cond
        [(empty? q) #f]
        [else
         (let* ([curr (car q)]
                [rest (cdr q)])
           (call-with-values (λ () (row-col curr))
                             (λ (r c)
                               (define reach (+ c (vector-ref (vector-ref grid r) c)))
                               (when (= r (- m 1)) (when (= c (- n 1)) (return (vector-ref dist curr))))
                               (for ([i (in-range 1 (add1 reach))])
                                 (let ([next-c (min (+ c i) (- n 1))]
                                       [next-idx (index r next-c)])
                                   (when (and (not (equal? (vector-ref dist next-idx) #f)) (< next-c (+ c i)))
                                     (set! i (- next-c c)))
                                   (when (and (= (vector-ref dist next-idx) #f) (not (equal? next-idx curr)))
                                     (vector-set! dist next-idx (+ (vector-ref dist curr) 1))
                                     (set! q (append rest (list next-idx))))))

                               (define reach-row (+ r (vector-ref (vector-ref grid r) c)))
                               (for ([i (in-range 1 (add1 reach-row))])
                                 (let ([next-r (min (+ r i) (- m 1))]
                                       [next-idx (index next-r c)])
                                   (when (and (not (equal? (vector-ref dist next-idx) #f)) (< next-r (+ r i)))
                                     (set! i (- next-r r)))
                                   (when (and (= (vector-ref dist next-idx) #f) (not (equal? next-idx curr)))
                                     (vector-set! dist next-idx (+ (vector-ref dist curr) 1))
                                     (set! q (append rest (list next-idx)))))))
           (set! q rest)
           (bfs)))]))

    (let ([result (bfs)])
      (if result result -1))))