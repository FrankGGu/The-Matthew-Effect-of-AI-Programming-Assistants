(define/contract (minimum-time s)
  (-> string? exact-integer?)
  (define n (string-length s))
  (define left (make-vector (add1 n) 0))
  (define right (make-vector (add1 n) 0))

  (for ([i (in-range 1 (add1 n))])
    (vector-set! left i 
                 (min (add1 (vector-ref left (sub1 i)))
                      (if (char=? (string-ref s (sub1 i)) #\1) i 0))))

  (for ([i (in-range (sub1 n) -1 -1)])
    (vector-set! right i 
                 (min (add1 (vector-ref right (add1 i)))
                      (if (char=? (string-ref s i) #\1) (- n i) 0))))

  (define min-time +inf.0)
  (for ([i (in-range (add1 n))])
    (set! min-time (min min-time (+ (vector-ref left i) (vector-ref right i)))))

  (exact-round min-time))