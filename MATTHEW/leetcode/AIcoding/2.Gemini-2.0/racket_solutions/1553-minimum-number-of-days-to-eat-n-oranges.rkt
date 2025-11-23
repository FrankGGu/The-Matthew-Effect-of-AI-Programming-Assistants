(define (min-days n)
  (letrec ((memo (make-hash))
           (helper (lambda (k)
                     (cond
                       ((<= k 0) 0)
                       ((hash-has-key? memo k) (hash-ref memo k))
                       (else
                        (let ((res (add1 (min (+ (modulo k 2) (helper (quotient k 2)))
                                              (+ (modulo k 3) (helper (quotient k 3)))))))
                          (hash-set! memo k res)
                          res))))))
    (helper n)))