(define (halve-array nums)
  (let* ([sum (/ (apply + nums) 2)]
         [heap (make-heap (lambda (a b) (> a b)))])
    (for ([num nums]) (heap-add! heap num))
    (let loop ([ops 0] [current-sum 0.0])
      (if (>= current-sum sum)
          ops
          (let* ([max-num (heap-remove! heap)]
                 [half-num (/ max-num 2)])
            (heap-add! heap half-num)
            (loop (+ ops 1) (+ current-sum half-num)))))))