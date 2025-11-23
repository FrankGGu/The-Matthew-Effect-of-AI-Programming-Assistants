(define (canConvertString s t k)
  (define n (string-length s))
  (define m (string-length t))
  (if (!= n m)
      #f
      (let* ([diffs (make-vector 26 0)]
             [max-freq 0])
        (for ([i (in-range n)])
          (let* ([s-char (string-ref s i)]
                 [t-char (string-ref t i)]
                 [diff (- (char->integer t-char) (char->integer s-char))])
            (when (< diff 0)
              (set! diff (+ diff 26)))
            (vector-set! diffs diff (+ 1 (vector-ref diffs diff)))))

        (for ([i (in-range 26)])
          (set! max-freq (max max-freq (vector-ref diffs i))))

        (<= (* (- max-freq 1) 26) k)))))