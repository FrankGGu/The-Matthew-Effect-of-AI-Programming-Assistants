(define (reverse-integer x)
  (define neg? (< x 0))
  (define abs-x (abs x))
  (define reversed 0)
  (define (helper n acc)
    (if (= n 0)
        acc
        (let* ((digit (remainder n 10))
               (new-acc (+ (* acc 10) digit)))
          (if (or (> new-acc 2147483647)
                  (< new-acc -2147483648))
              0
              (helper (quotient n 10) new-acc)))))
  (let ((result (helper abs-x 0)))
    (if neg?
        (- result)
        result)))