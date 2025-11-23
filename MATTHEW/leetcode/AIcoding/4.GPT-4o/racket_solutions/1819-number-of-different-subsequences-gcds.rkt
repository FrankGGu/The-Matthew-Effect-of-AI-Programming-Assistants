(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (mod a b))))

(define (countDifferentGCDs nums)
  (define max-num (apply max nums))
  (define gcds (make-vector (+ max-num 1) #f))
  (define unique-gcds (make-hash))

  (for ([i (in-range (length nums))])
    (let* ([num (list-ref nums i)]
           [mult (in-range num (+ max-num 1) num)])
      (for ([m mult])
        (define current-gcd (gcd num m))
        (when (not (vector-ref gcds current-gcd))
          (vector-set! gcds current-gcd #t)
          (hash-set! unique-gcds current-gcd #t)))))

  (hash-count unique-gcds))

(define (countDifferentGCDsMain nums)
  (countDifferentGCDs nums))