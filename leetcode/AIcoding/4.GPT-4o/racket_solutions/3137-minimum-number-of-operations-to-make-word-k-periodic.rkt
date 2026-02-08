(define (minOperations s k)
  (define n (string-length s))
  (define (count-mismatches start)
    (let loop ((i start) (count 0) (j 0))
      (if (>= i n)
          count
          (loop (+ i k) (if (char=? (string-ref s i) (string-ref s j)) count (+ count 1)) (if (>= j k) j 0)))))
  (define total-mismatches (for/sum ((j (in-range k)))
                               (count-mismatches j)))
  total-mismatches)

(define (main)
  (define s (read-line))
  (define k (read))
  (display (minOperations s k)))

(main)