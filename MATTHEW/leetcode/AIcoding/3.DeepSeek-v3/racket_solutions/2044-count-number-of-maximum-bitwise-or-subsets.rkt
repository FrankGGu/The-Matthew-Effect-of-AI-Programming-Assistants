(define (count-max-or-subsets nums)
  (let loop ([i 0] [current-or 0] [max-or 0] [count 0])
    (if (= i (length nums))
        (if (> current-or max-or) 1 (if (= current-or max-or) (+ count 1) count))
        (let* ([num (list-ref nums i)]
               [new-or (bitwise-ior current-or num)]
               [new-count (if (> new-or max-or) 1 (if (= new-or max-or) (+ count 1) count))])
          (loop (+ i 1) new-or (max max-or new-or) new-count)))))

  (let ([max-or (foldl bitwise-ior 0 nums)])
    (loop 0 0 0 0)))