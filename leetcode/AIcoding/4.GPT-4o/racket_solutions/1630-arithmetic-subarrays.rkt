(define (check-arithmetic subarray)
  (let ([diff (- (list-ref subarray 1) (list-ref subarray 0))])
    (for/fold ([prev (list-ref subarray 0)])
               ([i (in-range 2 (length subarray))])
      (let ([current (list-ref subarray i)])
        (if (= (- current prev) diff)
            current
            #f)))))

(define (arithmetic-subarrays nums l r)
  (let ([result '()])
    (for ([i (in-range (length l))])
      (define subarray (sublist nums (list-ref l i) (+ (list-ref r i) 1)))
      (set! result (cons (check-arithmetic subarray) result)))
    (map (lambda (x) (if x #t #f)) (reverse result))))

(define (arithmeticSubarrays nums l r)
  (arithmetic-subarrays nums l r))