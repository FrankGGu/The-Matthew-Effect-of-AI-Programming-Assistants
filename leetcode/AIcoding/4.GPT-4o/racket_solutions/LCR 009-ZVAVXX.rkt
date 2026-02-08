(define (numSubarrayProductLessThanK nums k)
  (define (count-subarrays left right)
    (if (>= left right)
        0
        (+ 1 (count-subarrays left (+ right 1)))))

  (define (helper nums k)
    (let loop ((left 0) (prod 1) (count 0))
      (if (>= left (length nums))
          count
          (let ((right left))
            (while (and (< right (length nums)) (< prod k))
              (set! prod (* prod (list-ref nums right)))
              (set! right (+ right 1)))
            (let ((valid-subarrays (if (< prod k) (count-subarrays left right) 0)))
              (loop (+ left 1) (if (< right (length nums)) (/ prod (list-ref nums left)) prod) (+ count valid-subarrays)))))))

  (if (<= k 1) 0 (helper nums k)))