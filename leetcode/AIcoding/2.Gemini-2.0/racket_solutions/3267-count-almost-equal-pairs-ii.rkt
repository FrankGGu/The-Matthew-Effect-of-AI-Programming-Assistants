(define (count-almost-equal-pairs nums k diff)
  (let* ([n (length nums)]
         [count (make-mutable-integer 0)]
         [heap (make-heap <)])
    (for ([i (in-range n)])
      (let loop ([j (in-range (- i 1) -1 -1)])
        (when (< (- i j) k)
          (let ([abs-diff (abs (- (list-ref nums i) (list-ref nums j)))])
            (when (<= abs-diff diff)
              (set! count (+ (mutable-integer-get count) 1)))))
        (when (< (- i j) k)
          (loop (- j 1)))))
    (mutable-integer-get count)))