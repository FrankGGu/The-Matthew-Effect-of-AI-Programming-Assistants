(define (longest-palindrome s)
  (let* ([n (string-length s)]
         [dp (make-vector n (make-vector n #f))]
         [start 0]
         [max-len 1])
    (for ([i (in-range n)])
      (vector-set! (vector-ref dp i) i #t))
    (for ([i (in-range (- n 1))])
      (if (string=? (substring s i (+ i 1)) (substring s (+ i 1) (+ i 2)))
          (begin
            (vector-set! (vector-ref dp i) (+ i 1) #t)
            (set! start i)
            (set! max-len 2))))
    (for ([k (in-range 3 (+ n 1))])
      (for ([i (in-range (- n k -1))])
        (let ([j (+ i k -1)])
          (if (and (string=? (substring s i (+ i 1)) (substring s j (+ j 1)))
                   (vector-ref (vector-ref dp (+ i 1)) (- j 1)))
              (begin
                (vector-set! (vector-ref dp i) j #t)
                (set! start i)
                (set! max-len k))))))
    (substring s start (+ start max-len))))