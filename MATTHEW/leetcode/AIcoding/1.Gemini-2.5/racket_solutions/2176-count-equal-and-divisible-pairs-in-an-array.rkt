(define (count-pairs nums k)
  (let* ([n (vector-length nums)]
         [count 0])
    (for ([i (in-range n)])
      (for ([j (in-range (+ i 1) n)])
        (when (and (= (vector-ref nums i) (vector-ref nums j))
                   (= (remainder (* i j) k) 0))
          (set! count (+ count 1)))))
    count))