(define (count-monotonic-pairs nums)
  (let ((n (length nums)))
    (for/sum ([i (in-range n)]
              [j (in-range (+ i 1) n)])
      (if (<= (list-ref nums i) (list-ref nums j))
          1
          0))))