(define (sort-list head)
  (define (get-length head)
    (if (null? head)
        0
        (+ 1 (get-length (cdr head)))))

  (define (split head length)
    (if (or (null? head) (<= length 1))
        (values head '())
        (let loop ([curr head] [count 1])
          (if (= count (floor (/ length 2)))
              (let ([next (cdr curr)])
                (set-cdr! curr '())
                (values head next))
              (loop (cdr curr) (+ count 1))))))

  (define (merge left right)
    (cond
      [(null? left) right]
      [(null? right) left]
      [(< (car left) (car right))
       (set-cdr! left (merge (cdr left) right))
       left]
      [else
       (set-cdr! right (merge left (cdr right)))
       right]))

  (define (merge-sort head length)
    (if (or (null? head) (<= length 1))
        head
        (let-values ([(left right) (split head length)])
          (merge (merge-sort left (floor (/ length 2)))
                 (merge-sort right (ceiling (/ length 2)))))))

  (merge-sort head (get-length head)))