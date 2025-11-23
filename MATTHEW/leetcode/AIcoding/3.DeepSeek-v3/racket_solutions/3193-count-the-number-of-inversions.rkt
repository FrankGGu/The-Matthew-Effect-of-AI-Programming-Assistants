(define (count-inversions nums)
  (define (merge-and-count left right)
    (let loop ((l left) (r right) (merged '()) (count 0))
      (cond
        [(and (null? l) (null? r)) (cons (reverse merged) count)]
        [(null? l) (loop l (cdr r) (cons (car r) merged) count)]
        [(null? r) (loop (cdr l) r (cons (car l) merged) count)]
        [(<= (car l) (car r)) (loop (cdr l) r (cons (car l) merged) count)]
        [else (loop l (cdr r) (cons (car r) merged) (+ count (length l))]))))

  (define (merge-sort-and-count lst)
    (if (<= (length lst) 1)
        (cons lst 0)
        (let* ((mid (quotient (length lst) 2))
              (left (take lst mid))
              (right (drop lst mid))
              (left-result (merge-sort-and-count left))
              (right-result (merge-sort-and-count right))
              (merge-result (merge-and-count (car left-result) (car right-result))))
          (cons (car merge-result)
                (+ (cdr left-result) (cdr right-result) (cdr merge-result))))))

  (cdr (merge-sort-and-count nums)))