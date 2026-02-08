(define (halves-are-alike s)
  (define vowels (set #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define (count-vowels str)
    (for/sum ([c str])
      (if (set-member? vowels c) 1 0)))
  (let* ([len (string-length s)]
         [half (/ len 2)]
         [a (substring s 0 half)]
         [b (substring s half len)])
    (= (count-vowels a) (count-vowels b))))