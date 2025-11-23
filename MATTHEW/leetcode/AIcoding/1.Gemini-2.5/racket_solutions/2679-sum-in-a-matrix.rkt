(require racket/list)

(define (sum-in-matrix nums)
  (let* ((num-cols (if (empty? nums) 0 (length (car nums)))))
    (let loop ((k num-cols) (current-nums nums) (total-score 0))
      (if (= k 0)
          total-score
          (let* ((row-maxes (map last current-nums))
                 (max-val (apply max row-maxes))
                 (next-nums (map butlast current-nums)))
            (loop (- k 1) next-nums (+ total-score max-val)))))))