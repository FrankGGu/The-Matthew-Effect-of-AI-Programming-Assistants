#lang racket

(define (maximum-accepted-elements nums)
  (define (cmp a b)
    (> a b))
  (define sorted (sort nums cmp))
  (define dp (make-hash))
  (define (dfs i)
    (hash-ref dp i (lambda ()
                     (let loop ((j (- i 1)) (res 0))
                       (if (< j 0)
                           (begin
                             (hash-set! dp i 1)
                             1)
                           (let ((val (if (>= (list-ref sorted i) (* 2 (list-ref sorted j))) (+ (dfs j) 1) 1)))
                             (loop (- j 1) (max res val))))))))
  (for/fold ((max-val 0)) ((i (in-range (length sorted))))
    (max max-val (dfs i))))

(provide maximum-accepted-elements)