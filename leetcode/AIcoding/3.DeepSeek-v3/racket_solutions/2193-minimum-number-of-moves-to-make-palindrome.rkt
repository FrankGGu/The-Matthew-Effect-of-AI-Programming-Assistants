(define (min-moves-to-make-palindrome s)
  (let loop ([s (string->list s)]
             [res 0])
    (if (<= (length s) 1)
        res
        (let ([first-char (car s)]
              [last-char (last s)])
          (if (equal? first-char last-char)
              (loop (cdr (reverse (cdr (reverse s)))) res)
              (let ([last-pos (index-of (reverse s) first-char)]
                    [first-pos (index-of s last-char)])
                (if (< last-pos first-pos)
                    (loop (append (take s (- (length s) last-pos 1))
                                 (drop s (- (length s) last-pos)))
                          (+ res last-pos))
                    (loop (append (take s first-pos)
                                 (drop s (+ first-pos 1)))
                          (+ res first-pos)))))))))