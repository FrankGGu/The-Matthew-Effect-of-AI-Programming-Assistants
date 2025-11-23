#lang racket

(define (digit-count n)
  (if (= n 0)
      1
      (add1 (digit-count (quotient n 10)))))

(define (is-palindrome? n)
  (define s (number->string n))
  (equal? s (reverse (string->list s))))

(define (generate-k-mirror-numbers k limit)
  (define (generate-odd-length palindrome len)
    (if (= len 0)
        (list (string->number (list->string (reverse (append (take palindrome (sub1 (quotient len 2))) (list #\0) (drop palindrome (quotient len 2)))))))
        (let ([new-palindrome (append (take palindrome (sub1 (quotient len 2))) (list (car (reverse palindrome))) (drop palindrome (quotient len 2)))])
          (cons (string->number (list->string (reverse new-palindrome)))
                (generate-odd-length new-palindrome (sub1 len))))))

  (define (generate-even-length palindrome len)
    (if (= len 0)
        (list (string->number (list->string (reverse (append (take palindrome (quotient len 2)) (drop palindrome (quotient len 2)))))))
        (let ([new-palindrome (append (take palindrome (sub1 (quotient len 2))) (list (car (reverse palindrome))) (drop palindrome (quotient len 2)))])
          (cons (string->number (list->string (reverse new-palindrome)))
                (generate-even-length new-palindrome (sub1 len))))))

  (define (generate-palindromes)
    (define (loop len)
      (if (> len 10)
          '()
          (append (generate-odd-length (list #\1) len)
                  (generate-even-length (list #\1) len)
                  (loop (add1 len)))))
    (loop 1))

  (define (is-k-mirror? n k)
    (define (check-base b)
      (and (>= b 2) (is-palindrome? (number->string n b))))
    (andmap check-base (range 2 (add1 k))))

  (define (helper lst res)
    (cond [(null? lst) res]
          [(and (is-k-mirror? (car lst) k) (< (length res) limit)) (helper (cdr lst) (append res (list (car lst))))]
          [else (helper (cdr lst) res)]))

  (sort (helper (generate-palindromes) '()) <))

(define (sum-of-k-mirror-numbers k)
  (define (sum-helper nums acc)
    (if (null? nums)
        acc
        (sum-helper (cdr nums) (+ acc (car nums)))))
  (sum-helper (take (generate-k-mirror-numbers k 100) 100) 0))