(define (check nums)
  (let* ((n (length nums))
         (count (for/sum ((i (in-range n)))
                    (if (> (list-ref nums i) (list-ref nums (modulo (+ i 1) n)))
                        1
                        0))))
    (or (= count 0) (= count 1))))