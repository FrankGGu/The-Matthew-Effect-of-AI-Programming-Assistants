(define (job-scheduling startTime endTime profit)
  (define n (length startTime))
  (define jobs (map list startTime endTime profit))
  (define sorted-jobs (sort jobs (lambda (a b) (< (second a) (second b)))))
  (define dp (make-vector (add1 n) 0))

  (define (binary-search idx)
    (if (< idx 0)
        0
        (let loop ((low 0) (high idx))
          (if (>= low high)
              low
              (let ((mid (quotient (+ low high) 2)))
                (if (< (second (list-ref sorted-jobs mid)) (first (list-ref sorted-jobs idx)))
                    (loop (add1 mid) high)
                    (loop low mid)))))))

  (for ((i (in-range n)))
    (define j (binary-search i))
    (vector-set! dp (add1 i) (max (vector-ref dp i) (+ (vector-ref dp j) (third (list-ref sorted-jobs i))))))

  (vector-ref dp n))

(define (max-profit-in-job-scheduling startTime endTime profit)
  (job-scheduling startTime endTime profit))