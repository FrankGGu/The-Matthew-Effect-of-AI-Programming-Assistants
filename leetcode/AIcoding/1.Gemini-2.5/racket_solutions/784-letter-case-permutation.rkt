(define (letter-case-permutation S)
  (let ([n (string-length S)])

    (define (backtrack idx current-chars)
      (if (= idx n)
          (list (list->string (reverse current-chars)))
          (let ([char (string-ref S idx)])
            (if (char-alphabetic? char)
                (append (backtrack (+ idx 1) (cons (char-downcase char) current-chars))
                        (backtrack (+ idx 1) (cons (char-upcase char) current-chars)))
                (backtrack (+ idx 1) (cons char current-chars))))))

    (backtrack 0 '())))