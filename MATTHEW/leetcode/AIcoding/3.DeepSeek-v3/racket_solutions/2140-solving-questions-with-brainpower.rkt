(define/contract (most-points questions)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let ([n (length questions)])
    (let ([dp (make-vector n 0)])
      (vector-set! dp (- n 1) (first (list-ref questions (- n 1))))
      (for ([i (in-range (- n 2) -1 -1)])
        (let* ([q (list-ref questions i)]
               [points (first q)]
               [brainpower (second q)]
               [next (if (>= (+ i brainpower 1) n) 0 (vector-ref dp (+ i brainpower 1)))])
          (vector-set! dp i (max (+ points next) (vector-ref dp (+ i 1))))))
      (vector-ref dp 0)))