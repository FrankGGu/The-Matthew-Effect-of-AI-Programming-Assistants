(define (happy-students nums)
  (define sorted-nums (sort nums <))
  (define n (length sorted-nums))
  (define (count-happy idx)
    (cond
      [(< idx n)
       (if (<= (list-ref sorted-nums idx) (+ idx 1))
           (+ 1 (count-happy (+ idx 1)))
           (count-happy (+ idx 1)))]
      [else 0]))

  (define (solve idx current-happy)
    (cond
      [(= idx n)
       (if (> current-happy 0) 1 0)]
      [(<= (list-ref sorted-nums idx) (+ current-happy 1))
       (+ (solve (+ idx 1) (+ current-happy 1))
          (solve (+ idx 1) current-happy))]
      [else
       (solve (+ idx 1) current-happy)]))

  (solve 0 0))