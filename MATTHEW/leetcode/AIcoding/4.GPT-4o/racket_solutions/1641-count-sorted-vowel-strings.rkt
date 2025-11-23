(define (countVowelStrings n)
  (define (combination k)
    (if (= k 0)
        1
        (apply + (map (lambda (x) (combination (- k 1))) (range 5)))))
  (combination n))

(countVowelStrings n)