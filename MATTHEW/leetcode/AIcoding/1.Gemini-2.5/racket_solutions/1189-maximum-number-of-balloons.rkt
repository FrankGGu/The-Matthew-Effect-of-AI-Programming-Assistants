(define (max-number-of-balloons text)
  (let ([counts (make-hash)])
    (for ([char (string->list text)])
      (hash-set! counts char (+ (hash-ref counts char 0) 1)))

    (let ([b-count (hash-ref counts #\b 0)]
          [a-count (hash-ref counts #\a 0)]
          [l-count (hash-ref counts #\l 0)]
          [o-count (hash-ref counts #\o 0)]
          [n-count (hash-ref counts #\n 0)])

      (min (quotient b-count 1)
           (quotient a-count 1)
           (quotient l-count 2)
           (quotient o-count 2)
           (quotient n-count 1)))))