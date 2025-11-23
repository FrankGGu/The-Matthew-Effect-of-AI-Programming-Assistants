(define (maximum-white-tiles covered)
  (define tiles (sort covered < #:key car))
  (define (solve tiles carpet-len)
    (let loop ([i 0] [j 0] [curr-len 0] [max-len 0])
      (cond
        [(>= j (length tiles)) max-len]
        [else
         (let* ([start-i (car (list-ref tiles i))]
                [end-i (cdr (list-ref tiles i))]
                [start-j (car (list-ref tiles j))]
                [end-j (cdr (list-ref tiles j))]
                [diff (- start-j start-i)])
           (if (<= diff carpet-len)
               (let ([new-curr-len (+ curr-len (- end-j start-j) 1)])
                 (if (>= (+ start-i carpet-len) end-j)
                     (loop i (+ j 1) new-curr-len (max max-len new-curr-len))
                     (let ([covered-len (+ start-i carpet-len)])
                       (loop i (+ j 1) new-curr-len (max max-len (+ curr-len (- covered-len start-j) 1)))))
                 )
               (let ([new-curr-len (- curr-len (- end-i start-i) 1)])
                 (loop (+ i 1) j new-curr-len max-len)))))])))
  (solve tiles (cadr covered)))