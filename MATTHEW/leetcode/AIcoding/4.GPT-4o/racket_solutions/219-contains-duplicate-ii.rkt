(define (containsNearbyDuplicate nums k)
  (define (helper nums k)
    (let loop ((seen '()) (i 0))
      (cond
        [(= i (length nums)) #f]
        [(and (member (list-ref nums i) seen)
              (<= (abs (- (index-of nums (list-ref nums i)) i)) k)) #t]
        [else (loop (cons (list-ref nums i) seen) (+ i 1))])))
  (helper nums k))