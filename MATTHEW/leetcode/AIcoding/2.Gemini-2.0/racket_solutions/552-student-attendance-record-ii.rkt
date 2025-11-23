(define (check-record n)
  (define modulo 1000000007)
  (define (dp i a l)
    (cond
      [(= i n) 1]
      [(>= a 2) 0]
      [(>= l 3) 0]
      [else
       (define p (make-parameter (make-hash)))
       (let ((key (list i a l)))
         (cond
           [(hash-has-key? (p) key) (hash-ref (p) key)]
           [else
            (let ((res (modulo (+ (dp (+ i 1) a 0)
                                   (modulo (+ (dp (+ i 1) (+ a 1) 0)
                                              (dp (+ i 1) a (+ l 1)) modulo) modulo)) modulo)))
              (hash-set! (p) key res)
              res)])))]))
  (dp 0 0 0))