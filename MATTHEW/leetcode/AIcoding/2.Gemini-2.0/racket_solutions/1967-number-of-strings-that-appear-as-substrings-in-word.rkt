(define (num-matching-substrings patterns word)
  (let loop ([patterns patterns] [count 0])
    (cond
      [(null? patterns) count]
      [(string-contains? word (car patterns)) (loop (cdr patterns) (+ count 1))]
      [else (loop (cdr patterns) count)])))