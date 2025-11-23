(define (detect-pattern arr m k)
  (let ((n (length arr)))
    (for*/first ((i (in-range 0 (- n (* m k) -1)))
                  #:when (let loop ((j 0))
                           (cond [(>= j (* m k)) #t]
                                 [(equal? (list-ref arr (+ i j)) (list-ref arr (+ i (modulo j m)))) (loop (+ j 1))]
                                 [else #f])))
      #t))
  #f)