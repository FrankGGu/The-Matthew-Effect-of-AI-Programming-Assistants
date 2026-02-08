(define (diffWaysToCompute input)
  (let loop ([s input])
    (let ([res '()])
      (for ([i (in-range (string-length s))])
        (let ([c (string-ref s i)])
          (when (or (char=? c #\+) (char=? c #\-) (char=? c #\*))
            (let* ([left (loop (substring s 0 i))]
                   [right (loop (substring s (add1 i)))])
              (for ([l left])
                (for ([r right])
                  (set! res (cons ((case c
                                     [(#\+) +]
                                     [(#\-) -]
                                     [(#\*) *]) l r) res)))))))))
      (if (null? res)
          (list (string->number s))
          res))))