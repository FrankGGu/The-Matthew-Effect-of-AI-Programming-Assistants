#lang racket

(define (longest-palindrome s)
  (define n (string-length s))
  (define dp (make-vector n (make-vector n #f)))
  (define max-len 0)
  (define start 0)

  (for ([i (in-range n)])
    (vector-set! (vector-ref dp i) i #t))

  (for ([i (in-range (- n 1))])
    (when (char=? (string-ref s i) (string-ref s (+ i 1)))
      (vector-set! (vector-ref dp i) (+ i 1) #t)
      (set! max-len 2)
      (set! start i)))

  (for ([len (in-range 3 (+ n 1))])
    (for ([i (in-range 0 (- n len -1))])
      (define j (+ i len -1))
      (when (and (char=? (string-ref s i) (string-ref s j))
        (vector-set! (vector-ref dp i) j (vector-ref (vector-ref dp (+ i 1)) (- j 1)))
        (when (vector-ref (vector-ref dp i) j)
          (when (> len max-len)
            (set! max-len len)
            (set! start i)))))))

  (if (> max-len 0)
      (substring s start (+ start max-len))
      ""))