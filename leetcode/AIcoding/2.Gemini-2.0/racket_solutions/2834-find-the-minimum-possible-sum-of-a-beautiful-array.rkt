(define (minimum-possible-sum n target)
  (let loop ((count 0) (i 1) (seen (set)) (sum 0))
    (if (= count n)
        sum
        (if (set-member? seen i)
            (loop count (+ i 1) seen sum)
            (if (set-member? seen (- target i))
                (loop count (+ i 1) seen sum)
                (loop (+ count 1) (+ i 1) (set-add seen i) (+ sum i)))))))