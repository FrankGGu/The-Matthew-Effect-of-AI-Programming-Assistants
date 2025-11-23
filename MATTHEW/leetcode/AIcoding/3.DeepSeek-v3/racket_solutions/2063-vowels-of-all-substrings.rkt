(define/contract (count-vowels word)
  (-> string? exact-integer?)
  (define vowels (set #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define n (string-length word))
  (define (vowel? c) (set-member? vowels c))
  (for/sum ([i (in-range n)]
            #:when (vowel? (string-ref word i)))
    (* (+ i 1) (- n i))))