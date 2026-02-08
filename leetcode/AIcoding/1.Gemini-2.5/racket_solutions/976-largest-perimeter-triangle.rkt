(define (largest-perimeter-triangle nums)
  (let* ((sorted-nums (sort nums >))
         (n (length sorted-nums)))
    (if (< n 3)
        0
        (let loop ((i 0))
          (if (>= (+ i 2) n)
              0
              (let* ((a (list-ref sorted-nums i))
                     (b (list-ref sorted-nums (+ i 1)))
                     (c (list-ref sorted-nums (+ i 2))))
                (if (> (+ b c) a)
                    (+ a b c)
                    (loop (+ i 1)))))))))