(define (num-of-pairs nums target)
  (let* ([n (length nums)]
         [count 0])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (when (not (= i j))
          (when (string=? (string-append (list-ref nums i) (list-ref nums j)) target)
            (set! count (+ count 1))))))
    count))