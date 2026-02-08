(define (merge-and-count left right)
  (define (helper left right count)
    (cond
      ((null? left) (values right count))
      ((null? right) (values left count))
      ((< (car left) (car right))
       (let-values ([(rest new-count) (helper (cdr left) right count)])
         (values (cons (car left) rest) new-count)))
      (else
       (let-values ([(rest new-count) (helper left (cdr right) (+ count (length left)))])
         (values (cons (car right) rest) new-count)))))
  (helper left right 0))

(define (sort-and-count lst)
  (if (or (null? lst) (null? (cdr lst)))
      (values lst 0)
      (let-values ([(mid left) (split-at (/ (length lst) 2) lst)]
                   [(sorted-left count-left) (sort-and-count left)]
                   [(sorted-right count-right) (sort-and-count mid)]
                   [(merged count-merge) (merge-and-count sorted-left sorted-right)])
        (values merged (+ count-left count-right count-merge)))))

(define (count-inversions arr)
  (let-values ([(sorted count) (sort-and-count arr)])
    count))

(define (reversePairs arr)
  (count-inversions arr))