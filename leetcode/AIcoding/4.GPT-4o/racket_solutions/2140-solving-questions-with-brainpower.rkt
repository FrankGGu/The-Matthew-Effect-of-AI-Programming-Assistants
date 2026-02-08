(define (mostPoints questions)
  (define n (length questions))
  (define dp (make-vector (+ n 1) 0))
  (for* ([i (in-range n)]
         [q (in-list questions)])
    (let* ([points (car q)]
           [brainpower (cadr q)]
           [next-i (+ i brainpower 1)])
      (vector-set! dp (+ i 1) (max (vector-ref dp (+ i 1)) 
                                    (+ points (if (< next-i n) 
                                                  (vector-ref dp next-i) 
                                                  0))))))
  (vector-ref dp n))

(define (solve)
  (let* ([questions (list (list 1 1) (list 2 2) (list 3 3))]) ; Replace with actual input
    (mostPoints questions)))