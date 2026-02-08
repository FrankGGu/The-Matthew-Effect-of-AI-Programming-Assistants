(define (min-penalty customers)
  (let* ([n (string-length customers)]
         [prefix-sum (make-vector (+ n 1) 0)]
         [_ (for/fold (void) ([i (in-range 0 n)])
              (vector-set! prefix-sum (+ i 1) (+ (vector-ref prefix-sum i) (if (char=? (string-ref customers i) #\N) 1 0))))]
         [min-penalty (vector-ref prefix-sum n)]
         [min-index n])
    (for ([i (in-range 0 (+ n 1))])
      (let ([penalty (+ i (- (vector-ref prefix-sum n) (vector-ref prefix-sum i)))])
        (when (< penalty min-penalty)
          (set! min-penalty penalty)
          (set! min-index i))))
    min-index))