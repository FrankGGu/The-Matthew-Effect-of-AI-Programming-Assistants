(define (min-insertions s)
  (define (helper s l r)
    (if (>= l r)
        0
        (if (= (string-ref s l) (string-ref s r))
            (helper s (+ l 1) (- r 1))
            (+ 1 (min (helper s (+ l 1) r) (helper s l (- r 1)))))))
  (helper s 0 (- (string-length s) 1)))