#lang racket

(require racket/math) ; For ceiling

(define (check-speed dist hour speed)
  (let ((n (length dist)))
    (let loop ((ds dist) (idx 0) (current-time 0.0))
      (if (null? ds)
          (<= current-time hour)
          (let ((d (car ds)))
            (loop (cdr ds)
                  (add1 idx)
                  (if (= (add1 idx) n) ; This is the last element (0-indexed idx, so (add1 idx) is 1-indexed count)
                      (+ current-time (/ (exact->inexact d) (exact->inexact speed)))
                      (+ current-time (ceiling (/ (exact->inexact d) (exact->inexact speed)))))))))))

(define (min-speed-on-time dist hour)
  (let ((n (length dist)))
    ;; If hour <= (n-1), it's impossible.
    ;; The first n-1 legs (if n > 1) each take at least 1 hour due to ceiling.
    ;; The last leg takes strictly positive time.
    ;; So, the total time will always be strictly greater than (n-1).
    ;; If the target hour is less than or equal to (n-1), it's impossible to meet.
    (if (and (> n 1) (<= hour (exact->inexact (- n 1))))
        -1
        (let loop ((low 1) (high 100000000000000) (ans -1)) ; Upper bound 10^14 for safety
          (if (> low high)
              ans
              (let* ((mid (floor (+ low (/ (- high low) 2))))) ; Calculate mid, ensuring it's an integer
                (if (check-speed dist hour mid)
                    (loop low (- mid 1) mid) ; Possible with mid speed, try lower
                    (loop (+ mid 1) high ans))))))))