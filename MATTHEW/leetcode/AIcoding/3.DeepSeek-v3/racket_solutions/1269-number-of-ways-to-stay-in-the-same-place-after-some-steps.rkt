#lang racket

(define (num-ways steps arr-len)
  (let* ([modulo (lambda (x) (modulo x 1000000007))]
         [max-pos (min (sub1 arr-len) steps)]
         [dp (make-vector (add1 max-pos) 0)])
    (vector-set! dp 0 1)
    (for ([step (in-range 1 (add1 steps))])
      (let ([new-dp (make-vector (add1 max-pos) 0)])
      (for ([pos (in-range 0 (add1 max-pos))])
        (let ([ways (vector-ref dp pos)])
        (when (> ways 0)
          (if (> pos 0)
              (vector-set! new-dp (sub1 pos) (modulo (+ (vector-ref new-dp (sub1 pos)) ways))))
          (vector-set! new-dp pos (modulo (+ (vector-ref new-dp pos) ways)))
          (if (< pos max-pos)
              (vector-set! new-dp (add1 pos) (modulo (+ (vector-ref new-dp (add1 pos)) ways)))))))
      (set! dp new-dp))
    (vector-ref dp 0)))