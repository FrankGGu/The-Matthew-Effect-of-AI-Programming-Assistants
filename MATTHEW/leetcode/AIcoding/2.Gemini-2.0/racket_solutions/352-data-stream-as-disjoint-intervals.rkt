(define (SummaryRanges)
  (let ((nums (set)))
    (define (addNum val)
      (set! nums (set-add nums val)))
    (define (getIntervals)
      (let loop ((sorted-nums (sort (set->list nums) <))
                 (intervals '()))
        (cond
          [(empty? sorted-nums) (reverse intervals)]
          [else
           (let loop2 ((current-interval (list (car sorted-nums) (car sorted-nums)))
                      (remaining-nums (cdr sorted-nums)))
             (cond
               [(empty? remaining-nums) (reverse (cons current-interval intervals))]
               [(= (car remaining-nums) (+ (cadr current-interval) 1))
                (loop2 (list (car current-interval) (car remaining-nums)) (cdr remaining-nums))]
               [else
                (loop2 current-interval remaining-nums)]))]))))

    (struct range (addNum getIntervals))
    (range addNum getIntervals)))