#lang racket

(define (minimize-manhattan-distances points)
  (define n (length points))

  (define u-values (map (lambda (p) (+ (car p) (cadr p))) points))
  (define v-values (map (lambda (p) (- (car p) (cadr p))) points))

  (define u-prefix-max (make-vector n))
  (define u-prefix-min (make-vector n))
  (define u-suffix-max (make-vector n))
  (define u-suffix-min (make-vector n))

  (define v-prefix-max (make-vector n))
  (define v-prefix-min (make-vector n))
  (define v-suffix-max (make-vector n))
  (define v-suffix-min (make-vector n))

  ;; Initialize prefix arrays
  (vector-set! u-prefix-max 0 (list-ref u-values 0))
  (vector-set! u-prefix-min 0 (list-ref u-values 0))
  (vector-set! v-prefix-max 0 (list-ref v-values 0))
  (vector-set! v-prefix-min 0 (list-ref v-values 0))

  (for ([i (in-range 1 n)])
    (vector-set! u-prefix-max i (max (vector-ref u-prefix-max (- i 1)) (list-ref u-values i)))
    (vector-set! u-prefix-min i (min (vector-ref u-prefix-min (- i 1)) (list-ref u-values i)))
    (vector-set! v-prefix-max i (max (vector-ref v-prefix-max (- i 1)) (list-ref v-values i)))
    (vector-set! v-prefix-min i (min (vector-ref v-prefix-min (- i 1)) (list-ref v-values i))))

  ;; Initialize suffix arrays
  (vector-set! u-suffix-max (- n 1) (list-ref u-values (- n 1)))
  (vector-set! u-suffix-min (- n 1) (list-ref u-values (- n 1)))
  (vector-set! v-suffix-max (- n 1) (list-ref v-values (- n 1)))
  (vector-set! v-suffix-min (- n 1) (list-ref v-values (- n 1)))

  (for ([i (in-range (- n 2) -1 -1)]) ; Loop from n-2 down to 0
    (vector-set! u-suffix-max i (max (vector-ref u-suffix-max (+ i 1)) (list-ref u-values i)))
    (vector-set! u-suffix-min i (min (vector-ref u-suffix-min (+ i 1)) (list-ref u-values i)))
    (vector-set! v-suffix-max i (max (vector-ref v-suffix-max (+ i 1)) (list-ref v-values i)))
    (vector-set! v-suffix-min i (min (vector-ref v-suffix-min (+ i 1)) (list-ref v-values i))))

  (define min-max-dist (expt 10 10)) ; Initialize with a sufficiently large number

  (for ([k (in-range n)])
    (define current-max-u (- (expt 10 10))) ; Smallest possible value for max
    (define current-min-u (expt 10 10))    ; Largest possible value for min
    (define current-max-v (- (expt 10 10)))
    (define current-min-v (expt 10 10))

    (when (> k 0)
      (set! current-max-u (max current-max-u (vector-ref u-prefix-max (- k 1))))
      (set! current-min-u (min current-min-u (vector-ref u-prefix-min (- k 1))))
      (set! current-max-v (max current-max-v (vector-ref v-prefix-max (- k 1))))
      (set! current-min-v (min current-min-v (vector-ref v-prefix-min (- k 1)))))

    (when (< k (- n 1))
      (set! current-max-u (max current-max-u (vector-ref u-suffix-max (+ k 1))))
      (set! current-min-u (min current-min-u (vector-ref u-suffix-min (+ k 1))))
      (set! current-max-v (max current-max-v (vector-ref v-suffix-max (+ k 1))))
      (set! current-min-v (min current-min-v (vector-ref v-suffix-min (+ k 1)))))

    (define dist-u (- current-max-u current-min-u))
    (define dist-v (- current-max-v current-min-v))
    (define current-max-manhattan (max dist-u dist-v))
    (set! min-max-dist (min min-max-dist current-max-manhattan)))

  min-max-dist)