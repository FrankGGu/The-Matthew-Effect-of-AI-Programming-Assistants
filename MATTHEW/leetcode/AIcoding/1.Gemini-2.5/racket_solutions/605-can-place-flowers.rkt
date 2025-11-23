(define (can-place-flowers flowerbed n)
  (let* ([len (length flowerbed)]
         [fb (list->vector flowerbed)]
         [count 0])
    (for ([i (in-range len)])
      (when (and (= (vector-ref fb i) 0)
                 (or (= i 0) (= (vector-ref fb (- i 1)) 0))
                 (or (= i (- len 1)) (= (vector-ref fb (+ i 1)) 0)))
        (vector-set! fb i 1)
        (set! count (+ count 1))))
    (>= count n)))