(define (halves-are-alike s)
  (define vowels (set #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define len (string-length s))
  (define first-half (substring s 0 (/ len 2)))
  (define second-half (substring s (/ len 2) len))

  (define (count-vowels str)
    (foldl (lambda (char acc)
             (if (set-member? vowels char)
                 (+ acc 1)
                 acc))
           0
           (string->list str)))

  (= (count-vowels first-half) (count-vowels second-half)))