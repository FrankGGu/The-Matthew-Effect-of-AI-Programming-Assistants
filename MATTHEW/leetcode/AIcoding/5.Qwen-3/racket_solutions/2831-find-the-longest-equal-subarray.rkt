#lang racket

(define (longest-equal-subarray nums k)
  (define (helper i j max-len)
    (if (> i j)
        max-len
        (let ((count (make-hash)))
          (let loop ((l i) (r i))
            (when (<= r (sub1 (vector-length nums)))
              (hash-set! count (vector-ref nums r) (add1 (hash-ref count (vector-ref nums r) 0)))
              (when (and (>= (hash-count count) 2) (<= (- r l) k))
                (set! max-len (max max-len (- r l))))
              (loop (add1 l) (add1 r))))))
  (helper 0 (sub1 (vector-length nums)) 0))