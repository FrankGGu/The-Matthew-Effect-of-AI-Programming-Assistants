(define (find-maximum-number-of-string-pairs words)
  (let* ([n (length words)]
         [count 0])
    (for ([i (in-range n)])
      (for ([j (in-range (+ i 1) n)])
        (when (string=? (list-ref words i) (string-reverse (list-ref words j)))
          (set! count (+ count 1)))))
    count))