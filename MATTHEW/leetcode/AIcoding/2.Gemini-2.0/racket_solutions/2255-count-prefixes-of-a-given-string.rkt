(define (count-prefixes words s)
  (let loop ([ws words] [count 0])
    (cond
      [(null? ws) count]
      [(string=? (substring s 0 (min (string-length s) (string-length (car ws)))) (car ws))
       (loop (cdr ws) (+ count 1))]
      [else (loop (cdr ws) count)])))