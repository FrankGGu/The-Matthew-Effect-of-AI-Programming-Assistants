(define (minPatches nums n)
  (let loop ([patches 0] [i 0] [reach 0])
    (cond
      [(>= reach n) patches]
      [(and (< i (length nums)) (<= (list-ref nums i) (+ reach 1)))
       (loop patches (+ i 1) (+ reach (list-ref nums i)))]
      [else
       (loop (+ patches 1) i (+ reach (+ reach 1)))])))