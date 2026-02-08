(define (longest-alternating-subarray nums threshold)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [max-len 0])

    (for ([i (in-range n)])
      (when (and (even? (vector-ref nums-vec i))
                 (<= (vector-ref nums-vec i) threshold))
        (let loop ([j (+ i 1)]
                   [current-len 1])
          (if (and (< j n)
                   (<= (vector-ref nums-vec j) threshold)
                   (not (= (remainder (vector-ref nums-vec j) 2)
                           (remainder (vector-ref nums-vec (- j 1)) 2))))
              (loop (+ j 1) (+ current-len 1))
              (set! max-len (max max-len current-len)))))
    max-len))