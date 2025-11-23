(define (getSumOfStringDigits s)
  (define (char->digit c)
    (- (char->integer c) (char->integer #\0)))

  (define (sum-digits n)
    (if (< n 10)
        n
        (sum-digits (apply + (map char->digit (number->string n))))))

  (sum-digits (apply + (map char->digit s))))

(define (getSumOfStringDigits s)
  (let* ((total (apply + (map char->digit s)))
         (res (if (< total 10) total (getSumOfStringDigits (number->string total)))))
    res))