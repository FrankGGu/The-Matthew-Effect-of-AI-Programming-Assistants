(define (max-students seats)
  (define n (vector-length seats))
  (define m (string-length (vector-ref seats 0)))

  (define (count-bits mask)
    (let loop ((m mask) (count 0))
      (if (zero? m)
          count
          (loop (bitwise-and m (sub1 m)) (add1 count)))))

  (define broken-seats-masks
    (for/vector ((r (in-range n)))
      (let loop ((c 0) (mask 0))
        (if (= c m)
            mask
            (loop (add1 c)
                  (if (char=? #\# (string-ref (vector-ref seats r) c))
                      (bitwise-ior mask (arithmetic-shift 1 c))
                      mask))))))

  (define dp (make-vector n))
  (for ((i (in-range n)))
    (vector-set! dp i (make-vector (arithmetic-shift 1 m) -1)))

  (define (is-valid-current-row-mask mask row-broken-mask)
    (and (zero? (bitwise-and mask (arithmetic-shift mask 1)))
         (zero? (bitwise-and mask row-broken-mask))))

  (define row0-broken-mask (vector-ref broken-seats-masks 0))
  (for ((current-mask (in-range (arithmetic-shift 1 m))))
    (when (is-valid-current-row-mask current-mask row0-broken-mask)
      (vector-set! (vector-ref dp 0) current-mask (count-bits current-mask))))

  (for ((r (in-range 1 n)))
    (define current-row-broken-mask (vector-ref broken-seats-masks r))
    (for ((current-mask (in-range (arithmetic-shift 1 m))))
      (when (is-valid-current-row-mask current-mask current-row-broken-mask)
        (define current-students (count-bits current-mask))
        (define max-prev-students -1)

        (for ((prev-mask (in-range (arithmetic-shift 1 m))))
          (when (not (= -1 (vector-ref (vector-ref dp (sub1 r)) prev-mask)))
            (when (and (zero? (bitwise-and current-mask prev-mask))
                       (zero? (bitwise-and current-mask (arithmetic-shift prev-mask 1)))
                       (zero? (bitwise-and current-mask (arithmetic-shift prev-mask -1))))
              (set! max-prev-students (max max-prev-students (vector-ref (vector-ref dp (sub1 r)) prev-mask))))))

        (when (not (= -1 max-prev-students))
          (vector-set! (vector-ref dp r) current-mask (+ current-students max-prev-students))))))

  (define max-total-students 0)
  (for ((mask (in-range (arithmetic-shift 1 m))))
    (set! max-total-students (max max-total-students (vector-ref (vector-ref dp (sub1 n)) mask))))

  max-total-students)