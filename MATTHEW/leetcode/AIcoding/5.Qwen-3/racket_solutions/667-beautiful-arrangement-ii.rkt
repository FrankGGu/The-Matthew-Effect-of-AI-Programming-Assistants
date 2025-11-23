(define (beautiful-arrangement-ii n k)
  (define (build-arr n k)
    (let loop ((i 1) (res '()) (diff k))
      (if (> i n)
          res
          (loop (+ i 1)
                (if (= diff 0)
                    (append res (range i n -1))
                    (cons i res))
                (if (= diff 0)
                    0
                    (- diff 1))))))
  (build-arr n k))