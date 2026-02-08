(define (find-first-almost-equal-substring s t len)
  (define (almost-equal? s-sub t-sub)
    (let loop ([i 0] [diff-count 0])
      (cond
        [(= i len) (= diff-count 1)]
        [(= diff-count 2) #f]
        [else (loop (+ i 1) (if (equal? (string-ref s-sub i) (string-ref t-sub i)) diff-count (+ diff-count 1)))])))

  (let loop ([i 0])
    (cond
      [(>= i (- (string-length s) len -1)) -1]
      [(almost-equal? (substring s i (+ i len)) (substring t i (+ i len))) i]
      [else (loop (+ i 1))])))