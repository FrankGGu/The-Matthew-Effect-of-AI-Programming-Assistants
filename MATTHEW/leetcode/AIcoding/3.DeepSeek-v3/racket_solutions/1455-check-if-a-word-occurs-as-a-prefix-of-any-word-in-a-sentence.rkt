(define (is-prefix-of-word sentence search-word)
  (let loop ([words (string-split sentence)] [i 1])
    (cond
      [(null? words) -1]
      [(string-prefix? (car words) search-word) i]
      [else (loop (cdr words) (+ i 1))])))