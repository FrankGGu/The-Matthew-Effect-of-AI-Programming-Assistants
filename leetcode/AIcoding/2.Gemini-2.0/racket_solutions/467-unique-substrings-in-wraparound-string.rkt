(define (find-substring-in-wrapround-string p)
  (define (char->int c)
    (- (char->integer c) (char->integer #\a)))

  (define (int->char i)
    (integer->char (+ i (char->integer #\a))))

  (define (next-char c)
    (int->char (modulo (+ (char->int c) 1) 26)))

  (define (solve p)
    (let* ([n (string-length p)]
           [dp (make-vector 26 0)])
      (for/fold ([max-len (make-vector 26 0)])
                ([i (in-range n)])
        (let ([curr-len 1])
          (cond
            [(and (> i 0)
                  (char=? (next-char (string-ref p (- i 1)))
                          (string-ref p i)))
             (set! curr-len (+ curr-len (vector-ref dp (- i 1))))]
            [else
             (set! curr-len 1)])
          (vector-set! dp i curr-len)
          (vector-set max-len (char->int (string-ref p i))
                      (max (vector-ref max-len (char->int (string-ref p i)))
                           curr-len)))
        max-len))

  (let ([max-lens (solve p)])
    (apply + (vector->list max-lens))))