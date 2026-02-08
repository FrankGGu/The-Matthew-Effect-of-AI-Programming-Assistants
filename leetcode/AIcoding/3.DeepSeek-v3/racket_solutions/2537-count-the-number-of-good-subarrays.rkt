(define (count-good nums k)
  (let loop ((left 0) (right 0) (count 0) (result 0) (freq (make-hash)))
    (cond
      [(>= right (length nums)) result]
      [(< count k)
       (let* ((num (list-ref nums right))
              (old-count (hash-ref freq num 0))
              (new-count (+ old-count 1)))
         (hash-set! freq num new-count)
         (loop left (+ right 1) (+ count (- new-count 1)) result freq))]
      [else
       (let* ((num-left (list-ref nums left))
              (old-count (hash-ref freq num-left 0))
              (new-count (- old-count 1)))
         (hash-set! freq num-left new-count)
         (loop (+ left 1) right (- count old-count) (+ result (- (length nums) right)) freq))])))