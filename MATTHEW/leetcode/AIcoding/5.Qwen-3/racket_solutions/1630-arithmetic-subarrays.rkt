#lang racket

(define (is-arithmetic? nums)
  (define n (length nums))
  (if (< n 2) #t
      (let* ([d (- (list-ref nums 1) (list-ref nums 0))])
        (for/and ([i (in-range 2 n)])
          (= (- (list-ref nums i) (list-ref nums (- i 1))) d)))))

(define (check-arithmetic-subarrays nums l r)
  (define (helper i)
    (if (> i (length l)) '()
        (let* ([start (list-ref l i)]
               [end (list-ref r i)]
               [sub (take (drop nums start) (- end start + 1))])
          (cons (is-arithmetic? sub) (helper (+ i 1))))))
  (helper 0))

(provide check-arithmetic-subarrays)