(require racket/base)

(define (minimum-seconds mountain)
  (let* ((max-h (apply max mountain))
         (sum-h (apply + mountain)))
    (if (= max-h 0)
        0
        (ceiling (/ sum-h max-h)))))