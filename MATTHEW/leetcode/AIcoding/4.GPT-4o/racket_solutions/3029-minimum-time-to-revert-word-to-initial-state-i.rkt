(define (minTimeToRevert word)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (mod a b))))
  (define (lcm a b)
    (/ (* a b) (gcd a b)))
  (define (cycle-length char)
    (let loop ((count 1) (pos (string-index word char)))
      (if (or (null? pos) (= pos 0))
          count
          (loop (+ count 1) (string-index word (string-ref word pos)))))
  (let ((distinct-chars (remove-duplicates (string->list word))))
    (apply lcm (map cycle-length distinct-chars))))