(define (shortest-impossible-sequence rolls k)
  (let loop ([rolls rolls] [count 1] [seen (make-hash)])
    (cond
      [(null? rolls) count]
      [else
       (hash-update! seen (car rolls) add1 0)
       (if (= (hash-count seen) k)
           (begin
             (hash-clear! seen)
             (loop (cdr rolls) (+ count 1) (hash-set seen (car rolls) 1)))
           (loop (cdr rolls) count seen))])))