(define (makesquare matchsticks)
  (define sum (apply + matchsticks))
  (if (or (zero? sum) (not (zero? (modulo sum 4))))
      #f
      (let* ((side-length (quotient sum 4))
             (n (length matchsticks))
             (dp (make-vector (expt 2 n) #f)))
        (vector-set! dp 0 #t)
        (define (solve mask current-sum)
          (cond
            [(vector-ref dp mask) (vector-ref dp mask)]
            [(> current-sum side-length) #f]
            [(= current-sum side-length)
             (vector-set! dp mask (solve mask 0))]
            [else
             (let loop ([i 0])
               (cond
                 [(>= i n) #f]
                 [(not (zero? (bitwise-and mask (expt 2 i)))) (loop (+ i 1))]
                 [else
                  (let ((new-mask (bitwise-ior mask (expt 2 i))))
                    (if (solve new-mask (+ current-sum (list-ref matchsticks i)))
                        (begin (vector-set! dp mask #t) #t)
                        (loop (+ i 1))))]))]))
        (solve 0 0)))))