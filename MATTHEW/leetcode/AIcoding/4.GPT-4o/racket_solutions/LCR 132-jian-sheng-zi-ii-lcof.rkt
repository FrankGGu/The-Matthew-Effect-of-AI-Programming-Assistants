(define (cut-wood lengths target)
  (define (can-cut length)
    (foldl (lambda (x acc) (+ acc (max 0 (- x length)))) 0 lengths))

  (define (binary-search low high)
    (if (> low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (>= (can-cut mid) target)
              (binary-search mid (- high 1))
              (binary-search (+ low 1) mid)))))

  (binary-search 0 (apply max lengths)))

(cut-wood (list 4 8 7 5) 5)