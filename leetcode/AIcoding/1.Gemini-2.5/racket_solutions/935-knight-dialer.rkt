(define (knight-dialer n)
  (define MOD 1000000007)

  (define (add-mod a b)
    (modulo (+ a b) MOD))

  (define moves
    (vector
     '(4 6)
     '(6 8)
     '(7 9)
     '(4 8)
     '(0 3 9)
     '()
     '(0 1 7)
     '(2 6)
     '(1 3)
     '(2 4)))

  (define dp (make-vector 10 1))

  (for ([_ (in-range 1 n)])
    (define next-dp (make-vector 10 0))
    (for ([digit (in-range 10)])
      (define current-count (vector-ref dp digit))
      (when (> current-count 0)
        (for ([next-digit (vector-ref moves digit)])
          (vector-set! next-dp next-digit
                       (add-mod (vector-ref next-dp next-digit) current-count)))))
    (set! dp next-dp))

  (define total-count 0)
  (for ([count (in-vector dp)])
    (set! total-count (add-mod total-count count)))

  total-count)