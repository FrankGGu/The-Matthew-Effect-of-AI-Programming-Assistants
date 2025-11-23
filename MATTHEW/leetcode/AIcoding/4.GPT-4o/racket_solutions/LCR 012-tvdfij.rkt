(define (pivotIndex nums)
  (define total (apply + nums))
  (define (find-pivot sum left-index)
    (if (>= left-index (length nums))
        -1
        (let ((right-sum (- total (list-ref nums left-index))))
          (if (= left-index 0)
              (if (= right-sum 0) left-index (find-pivot sum (+ left-index 1)))
              (if (= left-sum right-sum)
                  left-index
                  (find-pivot (+ left-sum (list-ref nums left-index)) (+ left-index 1)))))))
  (find-pivot 0 0))

(pivotIndex nums)