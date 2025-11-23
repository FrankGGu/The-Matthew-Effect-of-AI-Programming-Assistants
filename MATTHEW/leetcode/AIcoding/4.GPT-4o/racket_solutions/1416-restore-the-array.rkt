(define (numberOfArrays s k)
  (define n (string-length s))
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (min 11 (+ 1 i)))])
      (let* ([num (substring s (- i j) i)]
             [num-value (string->number num)])
        (when (and (<= 1 num-value k) (not (= (string-length num) 2 (and (char=? (string-ref num 0) #\0)) )))
          (vector-set! dp i (mod (+ (vector-ref dp i) (vector-ref dp (- i j))) mod)))))

  (vector-ref dp n))