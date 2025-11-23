(define (solution nums-list)
  (define n (length nums-list))

  (define nums (list->vector nums-list))

  (define P (make-vector (+ n 1) 0))
  (for ((i (in-range n)))
    (vector-set! P (+ i 1) (+ (vector-ref P i) (vector-ref nums i))))

  (define (lower-bound vec start end val)
    (let loop ((l start) (r end))
      (if (= l r)
          l
          (let ((mid (quotient (+ l r) 2)))
            (if (>= (vector-ref vec mid) val)
                (loop l mid)
                (loop (+ mid 1) r))))))

  (define (upper-bound vec start end val)
    (let loop ((l start) (r end))
      (if (= l r)
          l
          (let ((mid (quotient (+ l r) 2)))
            (if (> (vector-ref vec mid) val)
                (loop l mid)
                (loop (+ mid 1) r))))))

  (define count 0)

  (for ((i (in-range (- n 2))))
    (define S_L (vector-ref P (+ i 1)))

    (define min_Pj1 (* 2 S_L))
    (define max_Pj1 (floor-exact (/ (+ (vector-ref P n) S_L) 2)))

    (define k_min (+ i 2))
    (define k_max_exclusive n)

    (when (< k_min k_max_exclusive)
      (define idx_low (lower-bound P k_min k_max_exclusive min_Pj1))
      (define idx_high (upper-bound P k_min k_max_exclusive max_Pj1))

      (when (> idx_high idx_low)
        (set! count (+ count (- idx_high idx_low))))))

  count)