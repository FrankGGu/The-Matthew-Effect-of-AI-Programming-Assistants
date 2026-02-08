#lang racket

(require data/bit-vector)

(define (longest-dup-substring s)
  (define n (string-length s))
  (define mod 1000000007)
  (define base 26)
  (define (char-to-int c) (- (char->integer c) (char->integer #\a)))

  (define (search len)
    (define h (modular-inverse base mod))
    (define power (expt base (- len 1)) mod))
    (define hash 0)
    (define seen (make-hash))
    (for ([i (in-range len)])
      (set! hash (modulo (+ (* hash base) (char-to-int (string-ref s i))) mod))
    (hash-set! seen hash (sub1 len))
    (for ([i (in-range len n)])
      (define left-char (string-ref s (- i len)))
      (set! hash (modulo (- hash (* (char-to-int left-char) power))) mod))
      (set! hash (modulo (* hash base) mod))
      (set! hash (modulo (+ hash (char-to-int (string-ref s i))) mod))
      (define start (hash-ref seen hash #f))
      (if start
          (if (equal? (substring s (add1 start) (+ (add1 start) len))
                               (substring s (- i (sub1 len)) (add1 i)))
              (substring s (- i (sub1 len)) (add1 i))
              #f)
          (hash-set! seen hash (- i (sub1 len))))))
    #f)

  (define (binary-search left right)
    (if (> left right)
        ""
        (let* ([mid (quotient (+ left right) 2)]
               [result (search mid)])
          (if result
              (let ([longer (binary-search (add1 mid) right)])
                (if (non-empty-string? longer) longer result))
              (binary-search left (sub1 mid)))))))

  (binary-search 1 (sub1 n)))