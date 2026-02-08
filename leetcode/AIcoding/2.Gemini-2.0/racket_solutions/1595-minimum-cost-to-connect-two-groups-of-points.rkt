(define (connect-two-groups costs)
  (define m (length costs))
  (define n (length (car costs)))

  (define (solve i mask)
    (cond
      [(>= i m)
       (let loop ([j 0] [cost 0])
         (if (= j n)
             cost
             (if (bitwise-bit-set? mask j)
                 (loop (+ j 1) cost)
                 (let ([min-cost (apply min (for/list ([k m]) (list (list-ref (list-ref costs k) j))))])
                   (loop (+ j 1) (+ cost min-cost))))))]
      [else
       (let loop ([j 0] [min-cost +inf.0])
         (if (= j n)
             min-cost
             (let ([current-cost (+ (list-ref (list-ref costs i) j) (solve (+ i 1) (bitwise-ior mask (bitwise-bit-field #b1 j j))))])
               (loop (+ j 1) (min min-cost current-cost)))))]))

  (solve 0 0))