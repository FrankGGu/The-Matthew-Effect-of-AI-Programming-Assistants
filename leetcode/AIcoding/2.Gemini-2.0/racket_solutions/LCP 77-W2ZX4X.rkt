(define (rune-reserve runes)
  (let loop ([runes (sort runes <)]
             [count 1])
    (cond
      [(null? runes) count]
      [(null? (cdr runes)) count]
      [(= (+ 1 (car runes)) (cadr runes)) (loop (cdr runes) count)]
      [else (loop (cdr runes) (+ 1 count))])))