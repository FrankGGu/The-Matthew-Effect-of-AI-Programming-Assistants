(define (countSpecialSubstrings s k)
  (define (is-special? sub)
    (let ([count (foldl (lambda (char acc)
                          (if (member char acc) acc (cons char acc)))
                        '() sub)])
      (= (length count) (length sub))))

  (define (count k)
    (if (< (string-length s) k)
        0
        (foldl (lambda (i acc)
                  (if (is-special? (substring s i (+ i k)))
                      (+ acc 1)
                      acc))
                0 (range 0 (- (string-length s) k 1)))))

  (count k))

(countSpecialSubstrings "abcabc" 3)