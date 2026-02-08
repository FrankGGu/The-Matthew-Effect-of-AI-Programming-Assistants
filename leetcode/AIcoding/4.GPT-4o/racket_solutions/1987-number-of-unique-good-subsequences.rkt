(define (number-of-unique-good-subsequences binary)
  (define n (string-length binary))
  (define mod 1000000007)
  (define last-0 0)
  (define last-1 0)
  (define count 1)

  (for ((i (in-range n)))
    (cond
      ((char=? (string-ref binary i) #\1)
       (set! count (modulo (+ count last-0) mod))
       (set! last-1 count))
      ((char=? (string-ref binary i) #\0)
       (set! last-0 count))))

  (if (char=? (string-ref binary (sub1 n)) #\0)
      (sub1 count)
      count))

(define (unique-good-subsequences binary)
  (number-of-unique-good-subsequences binary))