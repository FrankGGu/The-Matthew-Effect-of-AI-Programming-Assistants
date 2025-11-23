(define (solve arr k)
  (let ((n (length arr)))
    (cond
      [(< n k) 0]
      [else
       (let loop ((i 0) (count 0))
         (cond
           [(>= i (- n k 0)) count]
           [else
            (let loop2 ((j 1))
              (cond
                [(>= j k) (loop (+ i 1) (+ count 1))]
                [else
                 (if (> (list-ref arr (+ i j)) (list-ref arr (+ i (- j 1))))
                     (loop2 (+ j 1))
                     (loop (+ i 1) count))]))])]))))