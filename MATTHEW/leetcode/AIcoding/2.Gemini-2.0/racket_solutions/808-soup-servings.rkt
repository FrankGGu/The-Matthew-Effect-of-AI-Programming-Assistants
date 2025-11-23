(define (soup-servings n)
  (define (memoize f)
    (let ((cache (make-hash)))
      (lambda args
        (let ((key (list->string (map (lambda (x) (number->string x)) args))))
          (if (hash-has-key? cache key)
              (hash-ref cache key)
              (let ((result (apply f args)))
                (hash-set! cache key result)
                result))))))

  (define (dp a b)
    (cond
      [(<= a 0) (if (<= b 0) 0.5 1.0)]
      [(<= b 0) 0.0]
      [else (* 0.25 (+ (dp (- a 100) (- b 0))
                       (dp (- a 75) (- b 25))
                       (dp (- a 50) (- b 50))
                       (dp (- a 25) (- b 75))))]))

  (define memo-dp (memoize dp))
  (let ((n (if (> n 5000) 5000 n)))
    (memo-dp n n)))