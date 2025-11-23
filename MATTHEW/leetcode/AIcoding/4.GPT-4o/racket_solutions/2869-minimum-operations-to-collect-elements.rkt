(define (minimumOperations nums)
  (define (count-operations start end)
    (if (>= start end)
        0
        (let ((current (list-ref nums start)))
          (if (= current 0)
              (count-operations (+ start 1) end)
              (+ 1 (count-operations (+ start 1) end))))))
  (count-operations 0 (length nums)))