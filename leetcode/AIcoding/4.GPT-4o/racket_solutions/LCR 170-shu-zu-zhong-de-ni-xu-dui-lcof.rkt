(define (reverse-pairs nums)
  (define (merge-sort lst)
    (if (< (length lst) 2)
        (list lst 0)
        (let* ((mid (quotient (length lst) 2))
               (left (take lst mid))
               (right (drop lst mid))
               (sorted-left (merge-sort left))
               (sorted-right (merge-sort right))
               (merged (merge (car sorted-left) (car sorted-right))
               (count (+ (cadr sorted-left) (cadr sorted-right)
                          (count-inversions left right))))
          (values merged count))))

  (define (merge left right)
    (cond
      [(null? left) right]
      [(null? right) left]
      [(<= (car left) (car right))
       (cons (car left) (merge (cdr left) right))]
      [else
       (cons (car right) (merge left (cdr right)))]))

  (define (count-inversions left right)
    (define (count-rec l r acc)
      (cond
        [(null? l) acc]
        [(null? r) acc]
        [(<= (car l) (car r))
         (count-rec (cdr l) r acc)]
        [else
         (count-rec l (cdr r) (+ acc (length l)))]))
    (count-rec left right 0))

  (define (count-reverse-pairs lst)
    (let-values (merge-sort lst)
      (cadr merge-sort)))

  (count-reverse-pairs nums))

(reverse-pairs '(7 5 6 4))