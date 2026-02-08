#lang racket

(define MOD 1000000007)
(define DIGITS 10)

(define (make-2d-vector rows cols initial-val)
  (build-vector rows (lambda (_) (build-vector cols (lambda (_) initial-val)))))

(define (make-3d-vector dim1 dim2 dim3 initial-val)
  (build-vector dim1 (lambda (_) (make-2d-vector dim2 dim3 initial-val))))

(define (char->digit c)
  (- (char->integer c) (char->integer #\0)))

(define (count-palindromic-subsequences s)
  (define n (string-length s))

  (when (< n 5)
    0)

  (define prefix-counts (make-2d-vector (add1 n) DIGITS 0))
  (define prefix-pairs (make-3d-vector (add1 n) DIGITS DIGITS 0))

  (define suffix-counts (make-2d-vector (add1 n) DIGITS 0))
  (define suffix-pairs (make-3d-vector (add1 n) DIGITS DIGITS 0))

  (for ([i (range 1 (add1 n))])
    (define current-char-digit (char->digit (string-ref s (sub1 i))))

    (for ([d (range DIGITS)])
      (vector-set! (vector-ref prefix-counts i) d (vector-ref (vector-ref prefix-counts (sub1 i)) d)))
    (vector-set! (vector-ref prefix-counts i) current-char-digit
                 (add1 (vector-ref (vector-ref prefix-counts i) current-char-digit)))

    (for ([d1 (range DIGITS)])
      (for ([d2 (range DIGITS)])
        (vector-set! (vector-ref (vector-ref prefix-pairs i) d1) d2
                     (vector-ref (vector-ref (vector-ref prefix-pairs (sub1 i)) d1) d2))))
    (for ([d1 (range DIGITS)])
      (vector-set! (vector-ref (vector-ref prefix-pairs i) d1) current-char-digit
                   (modulo (+ (vector-ref (vector-ref (vector-ref prefix-pairs i) d1) current-char-digit)
                              (vector-ref (vector-ref prefix-counts (sub1 i)) d1))
                           MOD))))

  (for ([i (range (sub1 n) -1 -1)])
    (define current-char-digit (char->digit (string-ref s i)))

    (for ([d (range DIGITS)])
      (vector-set! (vector-ref suffix-counts i) d (vector-ref (vector-ref suffix-counts (add1 i)) d)))
    (vector-set! (vector-ref suffix-counts i) current-char-digit
                 (add1 (vector-ref (vector-ref suffix-counts i) current-char-digit)))

    (for ([d1 (range DIGITS)])
      (for ([d2 (range DIGITS)])
        (vector-set! (vector-ref (vector-ref suffix-pairs i) d1) d2
                     (vector-ref (vector-ref (vector-ref suffix-pairs (add1 i)) d1) d2))))
    (for ([d2 (range DIGITS)])
      (vector-set! (vector-ref (vector-ref suffix-pairs i) current-char-digit) d2
                   (modulo (+ (vector-ref (vector-ref (vector-ref suffix-pairs i) current-char-digit) d2)
                              (vector-ref (vector-ref suffix-counts (add1 i)) d2))
                           MOD))))

  (define total-palindromes 0)

  (for ([k (range 2 (- n 2))])
    (for ([d1 (range DIGITS)])
      (for ([d2 (range DIGITS)])
        (define left-count (vector-ref (vector-ref (vector-ref prefix-pairs k) d1) d2))
        (define right-count (vector-ref (vector-ref (vector-ref suffix-pairs (add1 k)) d2) d1))
        (set! total-palindromes
              (modulo (+ total-palindromes
                         (modulo (* left-count right-count) MOD))
                      MOD)))))

  total-palindromes)