(define (largest-3-same-digit-number s)
  (define (get-max a b c)
    (if (and (char=? a b) (char=? b c))
        (string (list a b c))
        #f))
  (define (loop i max)
    (if (>= i (- (string-length s) 2))
        max
        (let* ((a (string-ref s i))
               (b (string-ref s (+ i 1)))
               (c (string-ref s (+ i 2)))
               (current (get-max a b c)))
          (if current
              (loop (+ i 1) (if (string>? current max) current max))
              (loop (+ i 1) max)))))
  (let ((result (loop 0 "")))
    (if (string=? result "")
        ""
        result)))