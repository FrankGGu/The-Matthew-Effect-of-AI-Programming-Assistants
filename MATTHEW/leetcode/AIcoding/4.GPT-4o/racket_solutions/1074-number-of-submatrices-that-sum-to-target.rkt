(define (num-submatrix-sum-target matrix target)
  (define (sum-rect matrix top left bottom right)
    (if (or (null? matrix) (null? (car matrix)))
        0
        (let loop ([i top] [sum 0])
          (if (> i bottom) 
              sum
              (loop (+ i 1) (+ sum (apply + (map (lambda (row) (apply + (subvector row left right))) (subvector matrix i (+ top 1))))))))))

  (define (count-sums sums)
    (define counts (make-hash))
    (for-each (lambda (s)
                 (hash-set! counts s (add1 (hash-ref counts s 0))))
               sums)
    (hash-ref counts target 0))

  (define (sum-submatrices matrix target)
    (define n (length matrix))
    (define m (length (car matrix)))
    (define total 0)
    (for ([left (in-range m)])
      (for ([right (in-range left m)])
        (define sums (list))
        (for ([row (in-range n)])
          (set! sums (cons (sum-rect matrix row left right) sums)))
        (set! total (+ total (count-sums sums)))))
    total)

  (sum-submatrices matrix target))