(define (findUnsortedSubarray nums)
  (define n (length nums))
  (define (is-sorted? lst)
    (cond
      [(null? lst) #t]
      [(null? (cdr lst)) #t]
      [else (and (<= (car lst) (cadr lst)) (is-sorted? (cdr lst)))]))
  (cond
    [(is-sorted? nums) 0]
    [else
     (let loop ([i 0] [j (- n 1)])
       (cond
         [(= i n) 0]
         [(= j -1) 0]
         [else
          (let* ([l (for/first ([k (in-range i n)]
                                 #:break (or (> k j)
                                               (not (equal? (list-ref nums k) (list-ref (sort (sublist nums i (+ j 1)) <) (- k i))))))
                            k)])
            (let* ([r (for/last ([k (in-range j -1 -1)]
                                #:break (or (< k i)
                                              (not (equal? (list-ref nums k) (list-ref (sort (sublist nums i (+ j 1)) <) (- k i))))))
                            k)])
              (- r l -1))))))]))