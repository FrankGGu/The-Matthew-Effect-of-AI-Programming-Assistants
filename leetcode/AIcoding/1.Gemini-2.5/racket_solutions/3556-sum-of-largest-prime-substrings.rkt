#lang racket

(define (is-prime? n)
  (cond
    ((< n 2) #f)
    ((= n 2) #t)
    ((even? n) #f)
    (else
     (let loop ((d 3))
       (cond
         ((> (* d d) n) #t)
         ((zero? (remainder n d)) #f)
         (else (loop (+ d 2))))))))

(define (sum-of-largest-prime-substrings s)
  (let* ((n (string-length s))
         (total-sum 0))
    (for ([i (in-range n)])
      (let ([max-prime-for-i 0])
        (for ([j (in-range i n)])
          (let* ((sub-str (substring s i (+ j 1)))
                 (num (string->number sub-str)))
            (when (and num (is-prime? num))
              (set! max-prime-for-i (max max-prime-for-i num)))))
        (set! total-sum (+ total-sum max-prime-for-i))))
    total-sum))