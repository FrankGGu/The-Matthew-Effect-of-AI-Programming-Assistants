(define/contract (can-reach s min-jump max-jump)
  (-> string? exact-integer? exact-integer? boolean?)
  (let* ([n (string-length s)]
         [dp (make-vector n #f)]
         [pre (make-vector (add1 n) 0)])
    (vector-set! dp 0 #t)
    (vector-set! pre 1 1)
    (for ([i (in-range 1 n)])
      (when (char=? (string-ref s i) #\0)
        (let ([l (max 0 (- i max-jump))]
              [r (- i min-jump)])
          (when (<= l r)
            (let ([sum (- (vector-ref pre (add1 r)) (vector-ref pre l))])
              (when (> sum 0)
                (vector-set! dp i #t))))))
      (vector-set! pre (add1 i) (+ (vector-ref pre i) (if (vector-ref dp i) 1 0))))
    (vector-ref dp (sub1 n))))