(define (kth-distinct arr k)
  (let loop ([lst arr]
             [count 0]
             [seen (make-hash)])
    (cond
      [(null? lst) ""]
      [(= count k) (car lst)]
      [(hash-ref seen (car lst) #f)
       (loop (cdr lst) count seen)]
      [else
       (hash-set! seen (car lst) #t
       (if (not (member (car lst) (cdr lst)))
           (loop (cdr lst) (add1 count) seen)
           (loop (cdr lst) count seen))])))