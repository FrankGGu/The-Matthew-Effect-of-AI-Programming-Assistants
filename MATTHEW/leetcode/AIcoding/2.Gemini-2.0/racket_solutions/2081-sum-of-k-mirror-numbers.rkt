(define (is-palindrome? num base)
  (let loop ([n num] [digits '()])
    (if (= n 0)
        (let ([len (length digits)])
          (let loop2 ([i 0])
            (if (>= i (/ len 2))
                #t
                (if (not (= (list-ref digits i) (list-ref digits (- len i 1))))
                    #f
                    (loop2 (+ i 1))))))
        (loop (quotient n base) (cons (remainder n base) digits)))))

(define (kth-mirror-numbers n k)
  (let loop ([i 1] [count 0] [sum 0])
    (if (> count n)
        sum
        (if (and (is-palindrome? i 10) (is-palindrome? i k))
            (loop (+ i 1) (+ count 1) (+ sum i))
            (loop (+ i 1) count sum))))

(define (solve n k)
  (kth-mirror-numbers n k))