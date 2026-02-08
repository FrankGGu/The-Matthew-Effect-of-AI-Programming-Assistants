(define (is-array-special nums queries)
  (define n (length nums))
  (define prefix (make-vector n 0))
  (for ([i (in-range 1 n)])
    (vector-set! prefix i 
                 (if (even? (+ (list-ref nums i) (list-ref nums (- i 1))))
                     (+ (vector-ref prefix (- i 1)) 1)
                     (vector-ref prefix (- i 1)))))
  (define (query x y)
    (if (>= x y)
        #t
        (zero? (- (vector-ref prefix y) (vector-ref prefix x)))))
  (map query (map car queries) (map cadr queries)))