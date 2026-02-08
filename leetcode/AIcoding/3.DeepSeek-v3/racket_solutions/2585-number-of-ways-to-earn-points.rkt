(define (ways-to-earn-points target types)
  (let* ([n (length types)]
         [dp (make-vector (+ target 1) 0)])
    (vector-set! dp 0 1)
    (for ([type types])
      (let ([count (first type)]
            [mark (second type)])
        (for ([i (in-range target (- mark 1) -1)])
          (for ([k (in-range 1 (+ count 1))])
            (when (>= (- i (* k mark)) 0)
              (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i (* k mark))))))))))
    (vector-ref dp target)))