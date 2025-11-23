(define (maxDistToClosest seats)
  (define n (length seats))
  (define left (make-vector n #f))
  (define right (make-vector n #f))

  (for ((i (in-range n)))
    (if (= (vector-ref seats i) 1)
        (begin
          (vector-set! left i 0)
          (for ((j (in-range (+ i 1 n))))
            (if (or (= (vector-ref seats j) 1) (= j n))
                (begin
                  (for ((k (in-range i j)))
                    (vector-set! left k (if (vector-ref left k) (vector-ref left k) (- j k))))
                  (set! i j)))))
    (if (= (vector-ref seats (- n 1 i)) 1)
        (begin
          (vector-set! right (- n 1 i) 0)
          (for ((j (in-range (- n 2 i) -1 -1)))
            (if (or (= (vector-ref seats j) 1) (= j -1))
                (begin
                  (for ((k (in-range j (+ i 1 n))))
                    (vector-set! right k (if (vector-ref right k) (vector-ref right k) (- k j))))
                  (set! i (- n 1 j)))))))

  (define max-distance 0)
  (for ((i (in-range n)))
    (when (= (vector-ref seats i) 0)
      (set! max-distance (max max-distance (min (vector-ref left i) (vector-ref right i))))))
  max-distance)