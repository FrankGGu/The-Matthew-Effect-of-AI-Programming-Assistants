(define (find-kth-number m n k)
  (define (count-less-or-equal x)
    (let loop ((i 1) (count 0))
      (if (> i m)
          count
          (loop (+ i 1) (+ count (min (quotient x i) n)))))))

  (let binary-search ((left 1) (right (* m n)))
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (>= (count-less-or-equal mid) k)
              (binary-search left mid)
              (binary-search (+ mid 1) right))))))