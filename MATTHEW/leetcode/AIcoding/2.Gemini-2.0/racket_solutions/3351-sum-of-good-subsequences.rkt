(define (sum-good-subsequences s)
  (define n (string-length s))
  (define mod 1000000007)
  (define (char->int c) (- (char->integer c) (char->integer #\0)))

  (define (solve idx current-sum)
    (cond
      [(>= idx n)
       (if (> current-sum 0) current-sum 0)]
      [else
       (let* ([digit (char->int (string-ref s idx))]
              [include-val (remainder (+ current-sum digit) mod)]
              [exclude-val current-sum])
         (remainder (+ (solve (+ idx 1) include-val)
                       (solve (+ idx 1) exclude-val)) mod))]))
  (solve 0 0))