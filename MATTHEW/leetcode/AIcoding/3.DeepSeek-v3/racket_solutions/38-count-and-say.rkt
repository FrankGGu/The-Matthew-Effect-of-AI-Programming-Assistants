(define (count-and-say n)
  (define (next-term s)
    (let loop ([s s] [count 1] [current (string-ref s 0)] [result ""])
      (if (null? (cdr (string->list s)))
          (string-append result (number->string count) (string current))
          (if (equal? (string-ref s 1) current)
              (loop (substring s 1) (+ count 1) current result)
              (loop (substring s 1) 1 (string-ref s 1) 
                    (string-append result (number->string count) (string current)))))))

  (if (= n 1)
      "1"
      (next-term (count-and-say (- n 1)))))