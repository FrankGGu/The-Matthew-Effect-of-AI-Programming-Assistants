(define (k-mirror k n)
  (define (palindrome-base-k x)
    (let loop ([x x] [res 0])
      (if (= x 0)
          res
          (loop (quotient x k) (+ (* res k) (remainder x k))))))

  (define (is-palindrome? x)
    (let loop ([s (number->string x)] [left 0] [right (sub1 (string-length s))])
      (or (>= left right)
          (and (char=? (string-ref s left) (string-ref s right))
               (loop s (add1 left) (sub1 right))))))

  (let loop ([i 1] [count 0] [sum 0])
    (if (= count n)
        sum
        (let ([pal (palindrome-base-k i)])
          (if (is-palindrome? pal)
              (loop (add1 i) (add1 count) (+ sum pal))
              (loop (add1 i) count sum)))))
)