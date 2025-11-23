(define (reverse-prefix word ch)
  (let loop ([i 0])
    (cond
      [(>= i (string-length word)) word]
      [(char=? (string-ref word i) ch)
       (string-append (string-reverse (substring word 0 (+ i 1))) (substring word (+ i 1) (string-length word)))]
      [else (loop (+ i 1))])))