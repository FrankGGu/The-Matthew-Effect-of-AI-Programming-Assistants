#lang racket

(define (number-of-beautiful-integers low high k)
  (define (digit-dp num)
    (define s (string->list (number->string num)))
    (define n (length s))
    (define memo (make-hash))

    (define (dp pos tight even odd leading-zero mask mod)
      (if (= pos n)
          (if (and (not leading-zero) (= even odd) (zero? mod))
          1
          0)
          (let ([key (list pos tight even odd leading-zero mask mod)])
            (if (hash-has-key? memo key)
                (hash-ref memo key)
                (let* ([max-digit (if tight (char->integer (list-ref s pos)) 9)]
                       [res 0])
                  (for ([d (in-range 0 (add1 max-digit))])
                    (let* ([new-tight (and tight (= d max-digit))]
                           [new-leading-zero (and leading-zero (zero? d))]
                           [new-even (if new-leading-zero even (if (even? d) (add1 even) even))]
                           [new-odd (if new-leading-zero odd (if (odd? d) (add1 odd) odd))]
                           [new-mask (if new-leading-zero mask (bitwise-ior mask (arithmetic-shift 1 d)))]
                           [new-mod (modulo (+ (* mod 10) d) k)])
                      (set! res (+ res (dp (add1 pos) new-tight new-even new-odd new-leading-zero new-mask new-mod)))))
                  (hash-set! memo key res)
                  res)))))

    (dp 0 #t 0 0 #t 0 0))

  (- (digit-dp high) (digit-dp (sub1 low))))