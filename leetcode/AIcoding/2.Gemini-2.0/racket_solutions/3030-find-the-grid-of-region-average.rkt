(define (average-grid grid)
  (define m (length grid))
  (define n (length (car grid)))
  (define result (make-list m (make-list n 0)))

  (define (calculate-average i j)
    (let* ([sum (for/sum ([row (in-range (max 0 (- i 1)) (min m (+ i 2)))]
                           [col (in-range (max 0 (- j 1)) (min n (+ j 2)))])
                      (list-ref (list-ref grid row) col))]
           [count (for/sum ([row (in-range (max 0 (- i 1)) (min m (+ i 2)))]
                             [col (in-range (max 0 (- j 1)) (min n (+ j 2)))])
                      1)])
      (if (= count 0)
          0
          (inexact->exact (round (/ sum count))))))

  (for/list ([i (in-range m)])
    (for/list ([j (in-range n)])
      (calculate-average i j))))