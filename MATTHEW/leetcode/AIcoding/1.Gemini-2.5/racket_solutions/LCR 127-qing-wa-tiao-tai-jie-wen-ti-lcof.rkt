(define (jump-training nums)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)])
    (if (<= n 1)
        0
        (let loop ([i 0]
                   [jumps 0]
                   [current-jump-end 0]
                   [farthest-reach 0])
          (if (>= i (- n 1))
              jumps
              (let* ([num-at-i (vector-ref nums-vec i)]
                     [new-farthest-reach (max farthest-reach (+ i num-at-i))])
                (if (= i current-jump-end)
                    (let* ([next-jumps (+ jumps 1)]
                           [next-current-jump-end new-farthest-reach])
                      (if (>= next-current-jump-end (- n 1))
                          next-jumps
                          (loop (+ i 1) next-jumps next-current-jump-end new-farthest-reach)))
                    (loop (+ i 1) jumps current-jump-end new-farthest-reach))))))))