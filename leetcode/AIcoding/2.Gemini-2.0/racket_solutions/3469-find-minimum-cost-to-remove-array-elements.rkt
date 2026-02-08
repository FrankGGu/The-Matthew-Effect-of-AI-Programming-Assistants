(define (minimum-cost nums cost)
  (let ((n (length nums)))
    (if (zero? n)
        0
        (let loop ((i 0) (curr-cost 0))
          (if (= i n)
              curr-cost
              (loop (+ i 1) (+ curr-cost (* (list-ref nums i) (list-ref cost (- n i 1))))))))))