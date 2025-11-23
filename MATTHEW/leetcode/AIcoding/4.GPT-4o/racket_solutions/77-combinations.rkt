(define (combine n k)
  (define (backtrack start path)
    (if (= (length path) k)
        (begin
          (set! result (cons (copy path) result)))
        (for-each (lambda (i)
                    (begin
                      (set! path (cons i path))
                      (backtrack (add1 i) path)
                      (set! path (cdr path))))
                  (range start (+ n 1)))))
  (define result '())
  (backtrack 1 '())
  (reverse result))

(define (range start end)
  (if (>= start end)
      '()
      (cons start (range (add1 start) end))))

(define (combine-main n k)
  (combine n k))