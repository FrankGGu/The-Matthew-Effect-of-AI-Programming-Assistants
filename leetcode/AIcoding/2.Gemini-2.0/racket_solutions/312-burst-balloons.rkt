(define (max-coins nums)
  (define n (length nums))
  (define new-nums (list* 1 nums 1))

  (define dp (make-vector (+ n 2) (make-vector (+ n 2) 0)))

  (for* ((len (in-range 2 (+ n 1)))
         (i (in-range 1 (- (+ n 1) len) 1)))
    (define j (+ i len))
    (for ((k (in-range i j)))
      (vector-set! (vector-ref dp i) j
                   (max (vector-ref (vector-ref dp i) j)
                        (+ (* (list-ref new-nums (- i 1))
                              (list-ref new-nums k)
                              (list-ref new-nums j))
                           (vector-ref (vector-ref dp i) k)
                           (vector-ref (vector-ref dp k) j))))))

  (vector-ref (vector-ref dp 1) (+ n 1)))