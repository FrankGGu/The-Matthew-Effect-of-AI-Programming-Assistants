(define (num-smaller-by-frequency s)
  (define (f s)
    (let* ([chars (string->list s)]
           [min-char (apply min chars)]
           [count (length (filter (lambda (c) (char=? c min-char)) chars))])
      count))
  (map f s))

(define (num-smaller-by-frequency queries words)
  (let* ([query-freqs (num-smaller-by-frequency queries)]
         [word-freqs (sort (num-smaller-by-frequency words) <)]
         [word-freqs-len (length word-freqs)])
    (map (lambda (qf)
           (let loop ([i 0])
             (cond
               [(= i word-freqs-len) 0]
               [(> (list-ref word-freqs i) qf) (- word-freqs-len i)]
               [else (loop (+ i 1))])))
         query-freqs)))