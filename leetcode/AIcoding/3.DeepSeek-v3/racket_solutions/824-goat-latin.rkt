(define (to-goat-latin sentence)
  (define vowels (set #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define words (string-split sentence))
  (define (process-word word index)
    (define first-char (string-ref word 0))
    (define new-word
      (if (set-member? vowels first-char)
          word
          (string-append (substring word 1) (substring word 0 1))))
    (string-append new-word "ma" (make-string (+ index 1) #\a)))
  (string-join (for/list ([word words] [i (in-naturals 1)])
                 (process-word word i)) " "))