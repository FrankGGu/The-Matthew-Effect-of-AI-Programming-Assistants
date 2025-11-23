(define (minimum-time-to-initial-state s k)
  (let* ([n (string-length s)])
    (let loop ([i 1])
      (if (>= (* i k) n)
          i
          (if (string=? (substring s (* i k) n) (substring s 0 (- n (* i k))))
              i
              (loop (+ i 1)))))))