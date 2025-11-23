(define (reverse-vowels s)
  (define vowels (string->list "aeiouAEIOU"))
  (define str-list (string->list s))
  (define vowel-indices (filter (lambda (i) (member (list-ref str-list i) vowels)) (range (string-length s))))
  (define (swap-vowels lst indices)
    (cond [(null? indices) lst]
          [else (let* ([i (car indices)]
                       [j (car (reverse indices))]
                       [temp (list-ref lst i)])
                  (list-set! lst i (list-ref lst j))
                  (list-set! lst j temp)
                  (swap-vowels lst (cdr (drop-right indices 1)))))])
  (list->string (swap-vowels str-list vowel-indices)))