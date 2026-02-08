#lang racket

(define (min-months n k relations)
  (define (popcount x)
    (bitwise-popcount x))

  (define prereqs (make-vector n 0))
  (for-each (lambda (rel)
              (define p (car rel))
              (define c (cdr rel))
              (vector-set! prereqs (- c 1)
                           (bitwise-ior (vector-ref prereqs (- c 1))
                                        (arithmetic-shift 1 (- p 1)))))
            relations)

  (define max-mask (arithmetic-shift 1 n))
  (define dp (make-vector max-mask (+ n 1)))

  (vector-set! dp 0 0)

  (for ([mask (in-range max-mask)])
    (when (< (vector-ref dp mask) (+ n 1))
      (define current-available 0)
      (for ([i (in-range n)])
        (when (and (= (bitwise-and mask (arithmetic-shift 1 i)) 0)
                   (= (bitwise-and (vector-ref prereqs i) mask) (vector-ref prereqs i)))
          (set! current-available (bitwise-ior current-available (arithmetic-shift 1 i)))))

      (define sub current-available)
      (when (> sub 0)
        (let loop ()
          (when (> sub 0)
            (when (<= (popcount sub) k)
              (define next-mask (bitwise-ior mask sub))
              (vector-set! dp next-mask (min (vector-ref dp next-mask) (+ (vector-ref dp mask) 1))))
            (set! sub (bitwise-and sub (- sub 1)))
            (loop)))))))

  (vector-ref dp (- max-mask 1)))