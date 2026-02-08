(define (reverse-pairs nums)
  (define (merge-and-count left right)
    (let loop ((i 0) (j 0) (count 0) (merged '()))
      (cond
        [(and (< i (length left)) (< j (length right)))
         (if (<= (list-ref left i) (* 2 (list-ref right j)))
             (loop (add1 i) j count (cons (list-ref left i) merged))
             (loop i (add1 j) (+ count (- (length left) i)) merged))]
        [else
         (let ((remaining (append (drop left i) (drop right j))))
           (values (append (reverse merged) remaining) count))])))

  (define (merge-sort-and-count lst)
    (if (<= (length lst) 1)
        (values lst 0)
        (let* ((mid (quotient (length lst) 2))
               (left (take lst mid))
               (right (drop lst mid))
               (left-result (merge-sort-and-count left))
               (right-result (merge-sort-and-count right))
               (merged-result (merge-and-count (car left-result) (car right-result))))
          (values (car merged-result) (+ (cdr left-result) (cdr right-result) (cdr merged-result))))))

  (cdr (merge-sort-and-count nums)))