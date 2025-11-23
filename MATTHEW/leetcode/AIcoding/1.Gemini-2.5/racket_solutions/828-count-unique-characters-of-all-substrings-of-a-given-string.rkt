(define (count-unique-chars s)
  (define n (string-length s))
  (define char-indices (make-vector 26 '()))

  (for ([i (in-range 26)])
    (vector-set! char-indices i (list -1)))

  (for ([i (in-range n)])
    (define char-code (- (char->integer (string-ref s i)) (char->integer #\A)))
    (vector-set! char-indices char-code
                 (append (vector-ref char-indices char-code) (list i))))

  (for ([i (in-range 26)])
    (vector-set! char-indices i
                 (append (vector-ref char-indices i) (list n))))

  (define total-sum 0)

  (for ([i (in-range 26)])
    (define indices (vector-ref char-indices i))
    (for ([j (in-range 1 (- (length indices) 1))])
      (define prev-idx (list-ref indices (- j 1)))
      (define curr-idx (list-ref indices j)))
      (define next-idx (list-ref indices (+ j 1)))
      (set! total-sum (+ total-sum (* (- curr-idx prev-idx) (- next-idx curr-idx))))))

  total-sum)