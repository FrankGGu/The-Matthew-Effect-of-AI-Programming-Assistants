(define (is-balanced? num)
  (let loop ((n num) (counts (make-vector 10 0)))
    (if (= n 0)
        (let ((is-valid #t))
          (for ((d (in-range 1 10)))
            (let ((count (vector-ref counts d)))
              (when (> count 0)
                (unless (= count d)
                  (set! is-valid #f)))))
          is-valid)
        (let ((digit (modulo n 10)))
          (if (= digit 0)
              #f
              (begin
                (vector-set! counts digit (+ (vector-ref counts digit) 1))
                (loop (quotient n 10) counts)))))))

(define (next-greater-numerically-balanced-number n)
  (let loop ((current-n (+ n 1)))
    (if (is-balanced? current-n)
        current-n
        (loop (+ current-n 1)))))