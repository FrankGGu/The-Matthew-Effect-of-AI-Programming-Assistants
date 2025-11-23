(define (count-inversions nums)
  (define (merge-sort-and-count lst)
    (define len (length lst))
    (if (<= len 1)
        (cons lst 0) ; Base case: sorted list and 0 inversions
        (let* ([mid (quotient len 2)]
               [left-half (take lst mid)]
               [right-half (drop lst mid)]
               [left-result (merge-sort-and-count left-half)]
               [right-result (merge-sort-and-count right-half)]
               [sorted-left (car left-result)]
               [inversions-left (cdr left-result)]
               [sorted-right (car right-result)]
               [inversions-right (cdr right-result)])
          (let-values ([(merged-list current-inversions) (merge sorted-left sorted-right)])
            (cons merged-list (+ inversions-left inversions-right current-inversions))))))

  (define (merge left-lst right-lst)
    (let loop ([l left-lst]
               [r right-lst]
               [acc '()]
               [inv-count 0])
      (cond
        [(empty? l) (cons (append (reverse acc) r) inv-count)]
        [(empty? r) (cons (append (reverse acc) l) inv-count)]
        [(<= (car l) (car r))
         (loop (cdr l) r (cons (car l) acc) inv-count)]
        [else ; (car l) > (car r)
         (loop l (cdr r) (cons (car r) acc) (+ inv-count (length l)))])))

  (cdr (merge-sort-and-count nums)))