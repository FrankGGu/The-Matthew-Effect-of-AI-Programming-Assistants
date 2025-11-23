#lang racket

(define (matrix-block-sum mat k)
  ;; Convert list-of-lists mat to vector-of-vectors for efficient access
  (define mat-vec (for/vector ([row mat]) (for/vector ([val row]) val)))

  (define m (vector-length mat-vec))
  (define n (vector-length (vector-ref mat-vec 0)))

  ;; Create prefix sum matrix P of size (m+1) x (n+1)
  (define P (make-vector (+ m 1) (lambda () (make-vector (+ n 1) 0))))

  ;; Populate P
  (for* ([r (in-range m)]
         [c (in-range n)])
    (vector-set! (vector-ref P (+ r 1)) (+ c 1)
                 (+ (vector-ref (vector-ref mat-vec r) c)
                    (vector-ref (vector-ref P r) (+ c 1))
                    (vector-ref (vector-ref P (+ r 1)) c)
                    (- (vector-ref (vector-ref P r) c)))))

  ;; Create result matrix ans
  (define ans (make-vector m (lambda () (make-vector n 0))))

  ;; Populate ans
  (for* ([i (in-range m)]
         [j (in-range n)])
    (define r1 (max 0 (- i k)))
    (define c1 (max 0 (- j k)))
    (define r2 (min (- m 1) (+ i k)))
    (define c2 (min (- n 1) (+ j k)))

    (define sum
      (+ (vector-ref (vector-ref P (+ r2 1)) (+ c2 1))
         (- (vector-ref (vector-ref P r1) (+ c2 1)))
         (- (vector-ref (vector-ref P (+ r2 1)) c1))
         (vector-ref (vector-ref P r1) c1)))
    (vector-set! (vector-ref ans i) j sum))

  ;; Convert ans back to list-of-lists for LeetCode output format
  (for/list ([row ans]) (for/list ([val row]) val)))