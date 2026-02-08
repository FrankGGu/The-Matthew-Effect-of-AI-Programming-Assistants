(define (count-beautiful-splits nums)
  (define (distinct-count lst)
    (length (remove-duplicates lst)))

  (define (helper idx acc)
    (cond
      [(>= idx (length nums)) acc]
      [else
       (let* ([left (take nums idx)]
              [right (drop nums idx)]
              [left-distinct (distinct-count left)]
              [right-distinct (distinct-count right)])
         (helper (+ idx 1) (+ acc (if (= left-distinct right-distinct) 1 0))))]))

  (helper 1 0))