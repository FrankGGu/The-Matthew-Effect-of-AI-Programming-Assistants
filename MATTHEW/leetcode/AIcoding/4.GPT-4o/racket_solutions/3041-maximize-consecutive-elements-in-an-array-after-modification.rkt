(define (maxConsecutiveElements nums k)
  (define (can-increase? target)
    (let loop ((i 0) (changes k))
      (cond
        ((>= i (length nums)) #t)
        ((> (vector-ref nums i) target) (loop (+ i 1) changes))
        ((> changes 0)
         (loop (+ i 1) (- changes 1)))
        (else #f))))

  (define (binary-search low high)
    (if (>= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (can-increase? mid)
              (binary-search mid high)
              (binary-search low mid)))))

  (binary-search 0 (apply max nums)))