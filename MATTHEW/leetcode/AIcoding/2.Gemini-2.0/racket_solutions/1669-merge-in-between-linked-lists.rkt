(define (merge-in-between-linked-lists list1 a b list2)
  (let loop1 ([curr list1] [i 0] [prev '()])
    (cond
      [(null? curr) list1]
      [(= i a)
       (let loop2 ([curr2 curr] [j i])
         (cond
           [(= j b)
            (if (null? prev)
                (begin
                  (set! list1 list2)
                  (let loop3 ([curr3 list2])
                    (cond
                      [(null? curr3) (set-tail! (last list2) (cdr curr2)) list1]
                      [(null? (cdr curr3)) (set-tail! curr3 (cdr curr2)) list1]
                      [else (loop3 (cdr curr3))]))
                  list1)
                (begin
                  (set-tail! prev list2)
                  (let loop3 ([curr3 list2])
                    (cond
                      [(null? curr3) (set-tail! (last list2) (cdr curr2)) list1]
                      [(null? (cdr curr3)) (set-tail! curr3 (cdr curr2)) list1]
                      [else (loop3 (cdr curr3))]))
                  list1))]
           [else (loop2 (cdr curr2) (+ j 1))]))]
      [else (loop1 (cdr curr) (+ i 1) curr)])))