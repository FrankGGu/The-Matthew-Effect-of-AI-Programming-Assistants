(define (can-be-sorted? nums)
  (define (check-sorted arr)
    (cond
      [(null? arr) #t]
      [(null? (cdr arr)) #t]
      [(<= (car arr) (cadr arr)) (check-sorted (cdr arr))]
      [else #f]))

  (define (merge-sort arr)
    (if (or (null? arr) (null? (cdr arr)))
        arr
        (let* ([mid (floor (/ (length arr) 2))]
               [left (take arr mid)]
               [right (drop arr mid)])
          (merge (merge-sort left) (merge-sort right)))))

  (define (merge left right)
    (cond
      [(null? left) right]
      [(null? right) left]
      [(<= (car left) (car right)) (cons (car left) (merge (cdr left) right))]
      [else (cons (car right) (merge left (cdr right)))]))

  (let ([sorted-nums (merge-sort nums)])
    (check-sorted sorted-nums)))