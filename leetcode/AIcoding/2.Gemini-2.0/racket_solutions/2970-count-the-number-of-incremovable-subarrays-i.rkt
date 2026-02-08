(define (count-incremovable-subarrays nums)
  (let* ((n (length nums))
         (count 0))
    (for* ([i (in-range n)]
           [j (in-range i n)])
      (let loop ([k 0] [prev -1] [removed? #f])
        (cond
          [(= k n)
           (set! count (+ count 1))]
          [(and (>= k i) (< k j))
           (loop (+ k 1) prev removed?)]
          [(> (list-ref nums k) prev)
           (loop (+ k 1) (list-ref nums k) removed?)]
          [else
           #f])))
    count))