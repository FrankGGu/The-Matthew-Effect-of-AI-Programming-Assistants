(define/contract (num-times-prefix-aligned flips)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [max-seen 0] [count 0])
    (if (>= i (length flips))
        count
        (let* ([current (list-ref flips i)]
               [new-max (max max-seen current)]
               [new-count (if (= new-max (+ i 1)) (+ count 1) count)])
          (loop (+ i 1) new-max new-count)))))