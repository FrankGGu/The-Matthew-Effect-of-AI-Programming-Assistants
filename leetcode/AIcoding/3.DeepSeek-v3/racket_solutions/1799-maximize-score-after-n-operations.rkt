#lang racket

(define (max-score nums)
  (let* ([n (quotient (length nums) 2)]
         [dp (make-vector (expt 2 (* 2 n)) -1)])
    (define (gcd-list lst)
      (define (gcd a b)
        (if (zero? b) a (gcd b (remainder a b))))
      (if (null? lst) 0 (apply gcd lst)))
    (define (dfs mask op)
      (if (> op n)
          0
          (if (not (= (vector-ref dp mask) -1))
              (vector-ref dp mask)
              (let ([max-score 0])
                (for ([i (in-range (* 2 n))])
                  (unless (bitwise-bit-set? mask i)
                    (for ([j (in-range (+ i 1) (* 2 n))])
                      (unless (bitwise-bit-set? mask j)
                        (let* ([new-mask (bitwise-ior mask (bitwise-ior (expt 2 i) (expt 2 j)))]
                               [current-score (* op (gcd (list-ref nums i) (list-ref nums j)))]
                               [total-score (+ current-score (dfs new-mask (+ op 1)))])
                          (when (> total-score max-score)
                            (set! max-score total-score)))))))
                (vector-set! dp mask max-score)
                max-score))))
    (dfs 0 1)))