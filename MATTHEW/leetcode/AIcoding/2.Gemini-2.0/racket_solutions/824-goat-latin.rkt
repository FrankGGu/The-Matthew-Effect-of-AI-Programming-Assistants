(define (goat-latin s)
  (define (vowel? c)
    (member? c '(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U)))

  (define (process-word word n)
    (cond
      [(vowel? (string-ref word 0))
       (string-append word "ma" (make-string n #\a))]
      [else
       (string-append (substring word 1 (string-length word)) (substring word 0 1) "ma" (make-string n #\a))]))

  (let loop ([words (string-split s)] [n 1] [result ""])
    (cond
      [(null? words) (substring result 1 (string-length result))]
      [else (loop (cdr words) (+ n 1) (string-append result " " (process-word (car words) n)))])))