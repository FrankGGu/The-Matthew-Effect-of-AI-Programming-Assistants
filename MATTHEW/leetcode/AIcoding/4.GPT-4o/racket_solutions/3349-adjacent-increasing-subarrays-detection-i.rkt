(define (adjacentIncreasingSubarrays nums)
  (define (helper nums start)
    (if (>= start (sub1 (length nums)))
        '()
        (let loop ((i start) (subarray '()))
          (cond
            [(= i (sub1 (length nums))) (if (null? subarray) '() (cons (reverse (cons (list (car subarray) (list (length subarray))) subarray)) '())))]
            [(< (list-ref nums i) (list-ref nums (add1 i)))
             (loop (add1 i) (cons (list-ref nums i) subarray))]
            [else (if (null? subarray)
                      (loop (add1 i) '())
                      (cons (reverse (cons (list (car subarray) (list (length subarray))) subarray)) (loop (add1 i) '())))])))]
  (helper nums 0))