#lang racket

(define (next-permutation nums)
  (define n (vector-length nums))

  (define (swap! vec i j)
    (let ([temp (vector-ref vec i)])
      (vector-set! vec i (vector-ref vec j))
      (vector-set! vec j temp)))

  (define (reverse-subvector! vec start end)
    (let loop ([i start] [j end])
      (when (< i j)
        (swap! vec i j)
        (loop (+ i 1) (- j 1)))))

  (let loop-k ([k (- n 2)])
    (cond
      ((< k 0)
       (reverse-subvector! nums 0 (- n 1)))
      ((< (vector-ref nums k) (vector-ref nums (+ k 1)))
       (let find-l ([l (- n 1)])
         (when (>= l (+ k 1))
           (if (< (vector-ref nums k) (vector-ref nums l))
               (begin
                 (swap! nums k l)
                 (reverse-subvector! nums (+ k 1) (- n 1)))
               (find-l (- l 1))))))
      (else
       (loop-k (- k 1)))))
  nums)