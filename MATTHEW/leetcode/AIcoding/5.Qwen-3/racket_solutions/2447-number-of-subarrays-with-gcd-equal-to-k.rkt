#lang racket

(define (subarrays-with-gcd-equal-k nums k)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define (solve)
    (let loop ([i 0] [count 0])
      (if (= i (length nums))
          count
          (let loop2 ([j i] [current-gcd 0])
            (if (= j (length nums))
                (loop (+ i 1) count)
                (let ([new-gcd (if (= current-gcd 0)
                                   (list-ref nums j)
                                   (gcd current-gcd (list-ref nums j)))])
                  (if (= new-gcd k)
                      (loop2 (+ j 1) new-gcd)
                      (loop2 (+ j 1) new-gcd))))))))

  (solve))