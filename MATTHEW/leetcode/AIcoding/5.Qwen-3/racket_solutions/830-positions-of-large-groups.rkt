(define (large-groups s)
  (define (helper i prev count result)
    (if (= i (string-length s))
        result
        (let ((current (string-ref s i)))
          (if (char=? current prev)
              (helper (+ i 1) current (+ count 1) result)
              (helper (+ i 1) current 1 (if (> count 2) (cons (list (- i 1) i) result) result))))))
  (reverse (helper 0 #\a 0 '())))