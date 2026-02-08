(define (pivotIndex nums)
  (define total (apply + nums))
  (define left-sum 0)
  (for/fold ([i 0]) ([num nums])
    (if (= left-sum (- total num))
        i
        (begin
          (set! left-sum (+ left-sum num))
          (+ i 1)))))
  -1)

(pivotIndex '(1 7 3 6 5 6)) ; example input