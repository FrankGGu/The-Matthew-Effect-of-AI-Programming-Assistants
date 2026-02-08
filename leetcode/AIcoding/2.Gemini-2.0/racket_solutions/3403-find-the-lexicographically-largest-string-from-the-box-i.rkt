(define (lexicographically-largest-string box)
  (let loop ([box box] [result ""])
    (cond [(empty? box) result]
          [else
           (let* ([max-char (apply max box)]
                  [new-box (remove max-char box #:count 1)])
             (loop new-box (string-append result (string max-char))))])))