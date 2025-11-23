(define (num-islands grid)
  (define rows (length grid))
  (if (zero? rows) 0
      (define cols (string-length (car grid)))
      (define visited (make-hash))
      (define (dfs r c)
        (when (and (>= r 0) (< r rows) (>= c 0) (< c cols)
                  (equal? #\1 (string-ref (list-ref grid r) c))
                  (not (hash-ref visited (cons r c) #f)))
          (hash-set! visited (cons r c) #t)
          (dfs (add1 r) c)
          (dfs (sub1 r) c)
          (dfs r (add1 c))
          (dfs r (sub1 c))))
      (let loop ([r 0] [c 0] [count 0])
        (cond
          [(= r rows) count]
          [(= c cols) (loop (add1 r) 0 count)]
          [(and (equal? #\1 (string-ref (list-ref grid r) c))
                (not (hash-ref visited (cons r c) #f)))
           (dfs r c)
           (loop r (add1 c) (add1 count))]
          [else (loop r (add1 c) count)]))))