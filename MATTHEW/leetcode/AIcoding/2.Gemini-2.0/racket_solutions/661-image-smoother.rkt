(define (image-smoother img)
  (let* ([m (length img)]
         [n (length (car img))]
         [smoothed-img (make-list m (make-list n 0))])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (let* ([count 0]
               [sum 0])
          (for ([x (in-range (max 0 (- i 1)) (min m (+ i 2)))])
            (for ([y (in-range (max 0 (- j 1)) (min n (+ j 2)))])
              (set! sum (+ sum (list-ref (list-ref img x) y)))
              (set! count (+ count 1))))
          (set! smoothed-img (list-set smoothed-img i (list-set (list-ref smoothed-img i) j (floor (/ sum count))))))))
    smoothed-img))