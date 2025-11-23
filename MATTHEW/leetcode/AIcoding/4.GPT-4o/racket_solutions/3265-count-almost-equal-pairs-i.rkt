(define (count-almost-equal-pairs nums)
  (define (count-pairs n)
    (let loop ((i 0) (j 0) (count 0))
      (cond
        ((= i n) count)
        ((= j n) (loop (+ i 1) (+ i 2) count))
        ((= (list-ref nums i) (list-ref nums j)) (loop i (+ j 1) count))
        (else (loop i (+ j 1) (+ count 1))))))
  (count-pairs (length nums)))