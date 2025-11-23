(define (range-sum-bst root low high)
  (cond
    [(null? root) 0]
    [(< (car root) low) (range-sum-bst (caddr root) low high)]
    [(> (car root) high) (range-sum-bst (cadr root) low high)]
    [else (+ (car root) (range-sum-bst (cadr root) low high) (range-sum-bst (caddr root) low high))]))