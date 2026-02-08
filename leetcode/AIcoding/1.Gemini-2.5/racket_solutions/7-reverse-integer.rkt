(require racket/control)

(define (reverse x)
  (define MAX_INT 2147483647)
  (define MIN_INT -2147483648)

  (let/ec exit
    (let loop ((num x) (rev 0))
      (if (= num 0)
          rev
          (let* ((digit (remainder num 10))
                 (next-num (quotient num 10)))
            (when (> rev (quotient MAX_INT 10)) (exit 0))
            (when (and (= rev (quotient MAX_INT 10)) (> digit 7)) (exit 0))
            (when (< rev (quotient MIN_INT 10)) (exit 0))
            (when (and (= rev (quotient MIN_INT 10)) (< digit -8)) (exit 0))
            (loop next-num (+ (* rev 10) digit)))))))