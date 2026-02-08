(define (countInterestingSubarrays nums modulo)
  (define (count-prefix-sums nums)
    (define prefix-sums (make-vector (add1 (vector-length nums)) 0))
    (for ([i (in-range (vector-length nums))])
      (vector-set! prefix-sums (add1 i) (+ (vector-ref prefix-sums i) (if (= (modulo (vector-ref nums i)) 1) 1 0))))
    prefix-sums)

  (define prefix-sums (count-prefix-sums nums))
  (define count 0)
  (define frequency (make-hash))

  (for ([i (in-range (vector-length nums))])
    (define current (if (= (modulo (vector-ref nums i)) 1) 1 0))
    (define target (if (= current 1) 1 0))
    (define needed (modulo (sub1 (vector-ref prefix-sums (add1 i)))))

    (hash-set! frequency needed (add1 (hash-ref frequency needed 0)))
    (set! count (+ count (hash-ref frequency (modulo (vector-ref prefix-sums (add1 i))) 0)))
    (if (= current 1)
        (hash-set! frequency (modulo (vector-ref prefix-sums (add1 i))) (add1 (hash-ref frequency (modulo (vector-ref prefix-sums (add1 i))) 0)))))

  count)

(define (countInterestingSubarrays nums)
  (countInterestingSubarrays nums (lambda (x) (mod x 2))))