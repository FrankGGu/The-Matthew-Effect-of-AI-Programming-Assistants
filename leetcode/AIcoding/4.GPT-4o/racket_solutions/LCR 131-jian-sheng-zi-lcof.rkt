(define (cut-wood lengths target)
  (define (can-cut? length)
    (if (zero? length) 0
        (max 0 (- length target))))

  (define (binary-search left right)
    (if (<= left right)
        (let* ((mid (quotient (+ left right) 2))
               (cut (foldl (lambda (x acc) (+ acc (can-cut? (- x mid)))) 0 lengths)))
          (if (>= cut target)
              (binary-search mid (- right 1))
              (binary-search (+ left 1) mid)))
        right))

  (binary-search 0 (apply max lengths)))

(cut-wood '(4 8 7) 4)