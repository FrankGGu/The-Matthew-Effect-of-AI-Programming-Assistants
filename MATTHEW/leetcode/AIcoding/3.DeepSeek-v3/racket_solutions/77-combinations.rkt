(define (combine n k)
  (define (helper start path res)
    (if (= (length path) k)
        (cons (reverse path) res)
        (let loop ([i start])
          (if (> i n)
              res
              (helper (+ i 1) (cons i path) (loop (+ i 1))))))
  (reverse (helper 1 '() '())))