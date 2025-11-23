(define (lexical-order n)
  (define result '())

  (define (dfs curr)
    (when (<= curr n)
      (set! result (cons curr result))

      (for ([i (in-range 0 10)])
        (define next-num (+ (* curr 10) i))
        (when (<= next-num n)
          (dfs next-num)))))

  (for ([i (in-range 1 10)])
    (when (<= i n)
      (dfs i)))

  (reverse result))