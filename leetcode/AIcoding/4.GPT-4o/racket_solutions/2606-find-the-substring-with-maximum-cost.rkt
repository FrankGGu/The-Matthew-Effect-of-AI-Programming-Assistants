(define (maximum-cost-substring s chars cost)
  (define char-cost (make-hash))
  (for ([i (in-range (string-length chars))])
    (hash-set! char-cost (string-ref chars i) (string-ref cost i)))
  (define max-cost 0)
  (define current-cost 0)
  (define found? #f)
  (for ([i (in-range (string-length s))])
    (define c (string-ref s i))
    (define c-cost (hash-ref char-cost c 0))
    (if (positive? c-cost)
        (begin
          (set! found? #t)
          (set! current-cost (+ current-cost c-cost)))
        (begin
          (if found?
              (begin
                (set! max-cost (max max-cost current-cost))
                (set! current-cost 0))
              (set! current-cost 0)))))
  (if found?
      (max max-cost current-cost)
      0))

(maximum-cost-substring "abcdef" "aeiou" "12345")