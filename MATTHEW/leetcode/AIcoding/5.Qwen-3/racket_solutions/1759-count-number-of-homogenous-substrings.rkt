(define (count-homogenous s)
  (define (helper i count res)
    (if (= i (string-length s))
        res
        (let ((current (string-ref s i)))
          (if (and (> i 0) (= current (string-ref s (- i 1))))
              (helper (+ i 1) (+ count 1) (+ res count))
              (helper (+ i 1) 1 (+ res 1)))))
  (helper 0 0 0))