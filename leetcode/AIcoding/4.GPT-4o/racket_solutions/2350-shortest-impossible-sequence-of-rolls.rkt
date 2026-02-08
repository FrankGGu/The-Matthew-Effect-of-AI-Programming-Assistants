(define (shortest-impossible-sequence rolls k)
  (define (can-form? seq k)
    (let loop ((i 0) (seen '()))
      (cond
        [(= i (length seq)) #t]
        [(member (list-ref seq i) seen) #f]
        [else (loop (+ i 1) (cons (list-ref seq i) seen))])))

  (define (find-sequence k)
    (define (iter n)
      (if (can-form? (take rolls n) k)
          (iter (+ n 1))
          n))
    (iter 1))

  (find-sequence k))