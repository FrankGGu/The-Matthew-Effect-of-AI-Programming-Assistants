(define (findKthNumber n k)
  (define (count_prefix x)
    (define (count_helper x n)
      (if (> x n) 0
          (+ (count_helper (* x 10) n)
             (if (> x 0) (min n (+ x 9)) 0))))
    (count_helper x n))

  (define (find_kth_number curr k)
    (if (<= k 0) curr
        (let loop ((i 0))
          (let ((count (count_prefix (+ curr i))))
            (if (< count k)
                (loop (+ i 1))
                (find_kth_number (* curr 10) (- k 1)))))))

  (find_kth_number 1 k))