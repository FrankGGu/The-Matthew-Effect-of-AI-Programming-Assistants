(define (soupServings N)
  (define (dp a b)
    (cond
      ((<= a 0) (if (<= b 0) 0.5 1.0))
      ((<= b 0) 0.0)
      ((hash-hash-ref dp-table (cons a b) #f) => (lambda (x) x))
      (else
        (define res (+ (dp (- a 100) b)
                       (dp (- a 75) (- b 25))
                       (dp (- a 50) (- b 50))
                       (dp (- a 25) (- b 75))))
        (hash-set! dp-table (cons a b) (/ res 4.0))))
  (define dp-table (make-hash))
  (if (>= N 5000) 1.0 (dp N N)))