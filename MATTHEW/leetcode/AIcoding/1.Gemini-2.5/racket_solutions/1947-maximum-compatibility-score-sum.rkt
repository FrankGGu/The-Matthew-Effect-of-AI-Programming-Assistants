#lang racket

(define (max-compatibility-sum students mentors)
  (define m (length students))
  (define n (length (car students)))

  (define (calculate-compatibility mentor student)
    (for/sum ([q-idx (in-range n)])
      (if (= (list-ref mentor q-idx) (list-ref student q-idx))
          1
          0)))

  (define (find-max-score mentor-idx student-mask)
    (if (= mentor-idx m)
        0
        (for/fold ([current-max 0])
                  ([s-idx (in-range m)])
          (if (zero? (bitwise-and student-mask (arithmetic-shift 1 s-idx)))
              (let* ((compat-score (calculate-compatibility (list-ref mentors mentor-idx)
                                                            (list-ref students s-idx)))
                     (remaining-score (find-max-score (add1 mentor-idx)
                                                      (bitwise-ior student-mask (arithmetic-shift 1 s-idx))))
                     (total-score (+ compat-score remaining-score)))
                (max current-max total-score))
              current-max))))

  (find-max-score 0 0))