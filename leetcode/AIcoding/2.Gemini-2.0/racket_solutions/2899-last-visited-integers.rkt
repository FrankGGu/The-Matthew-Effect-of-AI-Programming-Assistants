(define (last-visited integers)
  (define visited (list))
  (define result (list))
  (define (process-integer i)
    (cond
      [(equal? i "prev")
       (cond
         [(empty? visited) (set! result (cons -1 result))]
         [else (set! result (cons (car visited) result))])]
      [else (set! visited (cons i visited))]))
  (for-each process-integer integers)
  (reverse result))