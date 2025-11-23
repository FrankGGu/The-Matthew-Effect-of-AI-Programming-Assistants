(define (make-solution head)
  (struct solution (head) #:mutable)
  (solution head))

(define (solution-getRandom sol)
  (let loop ([node (solution-head sol)]
             [i 1]
             [result (solution-head sol)])
    (cond
      [(null? node) (cond [(eq? result #f) #f] [else (car result)])]
      [else
       (if (= (random i) 0)
           (loop (cdr node) (+ i 1) node)
           (loop (cdr node) (+ i 1) result))])))