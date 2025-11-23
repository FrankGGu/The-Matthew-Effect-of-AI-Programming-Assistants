(define (unique-letter-string s)
  (define n (string-length s))
  (define (char->idx c) (- (char->integer c) 65))
  (define pos (make-vector 26 (list -1 -1)))
  (define res 0)

  (for ([i (in-range n)])
    (define c (char->idx (string-ref s i)))
    (define lst (vector-ref pos c))
    (set! res (+ res (* (- i (second lst)) (- (first lst) (second lst)))))
    (vector-set! pos c (list i (first lst)))

  (for ([c (in-range 26)])
    (define lst (vector-ref pos c))
    (set! res (+ res (* (- n (second lst)) (- (first lst) (second lst))))))

  res)