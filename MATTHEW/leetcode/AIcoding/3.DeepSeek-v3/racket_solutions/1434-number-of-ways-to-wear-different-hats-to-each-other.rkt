(define MOD 1000000007)

(define (number-ways hats)
  (define n (length hats))
  (define max-hat (apply max (flatten hats)))
  (define hat-to-people (make-hash))

  (for ([hat (in-range 1 (add1 max-hat))])
    (hash-set! hat-to-people hat '()))

  (for ([person (in-range n)]
        [person-hats (in-list hats)])
    (for ([hat (in-list person-hats)])
      (hash-update! hat-to-people hat (lambda (lst) (cons person lst)) '())))

  (define dp (make-hash))
  (hash-set! dp 0 1)

  (for ([hat (in-range 1 (add1 max-hat))])
    (define new-dp (hash-copy dp))
    (for ([(mask count) (in-hash dp)])
      (for ([person (in-list (hash-ref hat-to-people hat '()))])
        (define new-mask (bitwise-ior mask (arithmetic-shift 1 person)))
        (when (not (bitwise-bit-set? mask person))
          (hash-update! new-dp new-mask (lambda (v) (modulo (+ v count) MOD)) 0)))
    (set! dp new-dp))

  (hash-ref dp (sub1 (arithmetic-shift 1 n)) 0)