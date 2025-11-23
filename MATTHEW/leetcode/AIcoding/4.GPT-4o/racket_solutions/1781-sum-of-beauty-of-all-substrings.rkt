(define (beautyOfSubstring s)
  (define (calculate-beauty substring)
    (let ([char-count (make-vector 26 0)])
      (for-each (lambda (c) (vector-set! char-count (- (char->integer c) 97) (+ 1 (vector-ref char-count (- (char->integer c) 97)))))
                substring)
      (let ([max-char (apply max (vector->list char-count))]
            [min-char (apply min (filter (lambda (x) (> x 0)) (vector->list char-count)))])
            [beauty (if (and (> max-char 0) (> min-char 0)) (- max-char min-char) 0)])
        beauty)))

  (define total-beauty 0)
  (for ([i (in-range (string-length s))])
    (for ([j (in-range i (string-length s))])
      (set! total-beauty (+ total-beauty (calculate-beauty (substring s i (+ j 1)))))))
  total-beauty)

(define (sumOfBeauty s)
  (beautyOfSubstring s))