(define (is-palindrome? n)
  (let ((s (number->string n)))
    (equal? s (string-reverse s))))

(define (k-to-base n k)
  (let loop ((m n) (result ""))
    (if (= m 0)
        result
        (loop (quotient m k) (string-append (number->string (modulo m k)) result)))))

(define (is-k-palindrome? n k)
  (is-palindrome? (k-to-base n k)))

(define (k-mirror k n)
  (define (count-mirror count num)
    (if (>= count n)
        num
        (let loop ((i num))
          (if (is-k-palindrome? i k)
              (count-mirror (add1 count) i)
              (loop (add1 i))))))
  (count-mirror 0 1))

(define (sum-of-k-mirror k n)
  (define (sum-mirror count sum num)
    (if (>= count n)
        sum
        (if (is-k-palindrome? num k)
            (sum-mirror (add1 count) (+ sum num) (add1 num))
            (sum-mirror count sum (add1 num)))))
  (sum-mirror 0 0 1))

(define (k-mirror-sum k n)
  (sum-of-k-mirror k n))

(k-mirror-sum 2 5)