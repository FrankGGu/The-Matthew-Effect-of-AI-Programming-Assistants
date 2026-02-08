(define (find-kth-positive arr k)
  (let loop ([i 0] [count 0] [num 1])
    (cond
      [(= count k) num]
      [(and (< i (length arr)) (= (list-ref arr i) num)) (loop (+ i 1) count (+ num 1))]
      [else (loop i (+ count 1) (+ num 1))])))