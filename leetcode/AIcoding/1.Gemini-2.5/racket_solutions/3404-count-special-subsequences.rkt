#lang racket

(define (count-special-subsequences s)
  (define M 1000000007) ; 10^9 + 7

  (let loop ((chars (string->list s))
             (dp1 0) ; Number of subsequences of type '1' (single '1')
             (dp2 0) ; Number of subsequences of type '12' (single '1', single '2')
             (dp3 0)) ; Number of subsequences of type '123' (single '1', single '2', single '3')
    (if (null? chars)
        dp3
        (let* ((c (car chars))
               (digit (- (char->integer c) (char->integer #\0))))
          (case digit
            ((1)
             (loop (cdr chars)
                   (modulo (+ dp1 1) M)
                   dp2
                   dp3))
            ((2)
             (loop (cdr chars)
                   dp1
                   (modulo (+ dp2 dp1) M)
                   dp3))
            ((3)
             (loop (cdr chars)
                   dp1
                   dp2
                   (modulo (+ dp3 dp2) M)))
            (else ; For '0', '4', '5', '6', '7', '8', '9'
             (loop (cdr chars) dp1 dp2 dp3)))))))