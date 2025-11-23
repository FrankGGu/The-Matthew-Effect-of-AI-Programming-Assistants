(define (integerReplacement n)
  (define (helper n memo)
    (cond
      [(hash-has-key? memo n) (hash-ref memo n)]
      [(= n 1) 0]
      [(even? n) (let ([result (+ 1 (helper (/ n 2) memo))])
                   (hash-set! memo n result)
                   result)]
      [else (let ([result (+ 1 (min (helper (+ n 1) memo) (helper (- n 1) memo)))])
              (hash-set! memo n result)
              result)]))
  (helper n (make-hash)))