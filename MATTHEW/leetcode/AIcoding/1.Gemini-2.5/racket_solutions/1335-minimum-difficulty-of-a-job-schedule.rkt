(define (min-difficulty jobDifficulty d)
  (define jobs-vec (list->vector jobDifficulty))
  (define n (vector-length jobs-vec))

  (if (< n d)
      -1
      (begin
        (define dp (make-vector (+ d 1)))
        (for ([k (in-range (+ d 1))])
          (vector-set! dp k (make-vector (+ n 1) +inf.0)))

        (vector-set! (vector-ref dp 0) 0 0)

        (for ([k (in-range 1 (+ d 1))])
          (for ([i (in-range 1 (+ n 1))])
            (when (>= i k)
              (define current-max-difficulty 0)
              (for ([j (in-range (- i 1) (- k 2) -1)])
                (set! current-max-difficulty (max current-max-difficulty (vector-ref jobs-vec j)))
                (when (not (equal? (vector-ref (vector-ref dp (- k 1)) j) +inf.0))
                  (vector-set! (vector-ref dp k) i
                               (min (vector-ref (vector-ref dp k) i)
                                    (+ (vector-ref (vector-ref dp (- k 1)) j) current-max-difficulty))))))))

        (define result (vector-ref (vector-ref dp d) n))
        (if (equal? result +inf.0)
            -1
            result))))