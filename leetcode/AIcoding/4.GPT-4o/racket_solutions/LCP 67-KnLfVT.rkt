(define (countDecorations n)
  (define (helper n)
    (if (= n 0)
        1
        (if (= n 1)
            1
            (+ (helper (- n 1)) (helper (- n 2))))))
  (helper n))

(countDecorations 5)