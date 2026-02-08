(define (subarray-sum-equals-k nums k)
  (let loop ([nums nums] [count 0] [sum-map (dict '(0 . 1))] [curr-sum 0])
    (if (null? nums)
        count
        (let* ([first (car nums)]
               [new-sum (+ curr-sum first)]
               [diff (- new-sum k)]
               [new-count (if (dict-has-key? sum-map diff)
                              (+ count (dict-ref sum-map diff))
                              count)]
               [new-sum-map (dict-update sum-map new-sum (lambda (v) (+ v 1)) 1)])
          (loop (cdr nums) new-count new-sum-map new-sum)))))