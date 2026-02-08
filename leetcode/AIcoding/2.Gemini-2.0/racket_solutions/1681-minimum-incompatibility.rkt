(define (minimum-incompatibility nums k)
  (define n (length nums))
  (define group-size (/ n k))
  (define memo (make-hash))

  (define (solve mask)
    (cond
      [(equal? mask (expt 2 n)) 0]
      [(hash-has-key? memo mask) (hash-ref memo mask)]
      [else
       (define min-incompatibility +inf.0)
       (for* ([subset (subsets nums mask group-size)])
             (let ([new-mask (foldl (lambda (i acc) (bitwise-ior acc (expt 2 i))) mask subset)])
               (define incompatibility (incompatibility subset))
               (when (not (equal? incompatibility -1))
                 (set! min-incompatibility (min min-incompatibility (+ incompatibility (solve new-mask)))))))
       (hash-set! memo mask min-incompatibility)
       min-incompatibility]))

  (define (subsets nums mask group-size)
    (define indices (filter (lambda (i) (zero? (bitwise-and mask (expt 2 i)))) (range n)))
    (define result '())
    (define (backtrack current-subset remaining-indices)
      (cond
        [(equal? (length current-subset) group-size)
         (set! result (cons current-subset result))]
        [(empty? remaining-indices) #f]
        [else
         (let ([first-index (car remaining-indices)]
               [rest-indices (cdr remaining-indices)])
           (backtrack (cons first-index current-subset) rest-indices)
           (backtrack current-subset rest-indices))]))

    (backtrack '() indices)
    result)

  (define (incompatibility subset)
    (if (equal? (length (remove-duplicates (map (lambda (i) (list-ref nums i)) subset))) (length subset))
        (- (apply max (map (lambda (i) (list-ref nums i)) subset)) (apply min (map (lambda (i) (list-ref nums i)) subset)))
        -1))

  (let ([result (solve 0)])
    (if (equal? result +inf.0) -1 result)))