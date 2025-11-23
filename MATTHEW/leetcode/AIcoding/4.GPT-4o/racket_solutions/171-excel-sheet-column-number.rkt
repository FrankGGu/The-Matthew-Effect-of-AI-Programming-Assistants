(define (titleToNumber s)
  (define (char-value c)
    (- (char->integer c) (char->integer #\A) 1))
  (foldl (lambda (c acc) (+ (* 26 acc) (char-value c))) 0 (string->list s)))

(titleToNumber "AB")