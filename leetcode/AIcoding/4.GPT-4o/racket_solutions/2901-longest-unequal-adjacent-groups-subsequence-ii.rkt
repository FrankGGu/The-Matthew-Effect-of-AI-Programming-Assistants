(define (longest-unequal-adjacent-groups-subsq nums)
  (define n (length nums))
  (define (max-length start prev count)
    (if (>= start n)
        count
        (let ([new-count (if (not (= (list-ref nums start) prev)) (+ count 1) count)])
          (max (max-length (+ start 1) (list-ref nums start) new-count)
               (max-length (+ start 1) prev count)))))
  (max-length 0 #f 0))

(define (longestUnunequalAdjGroups nums)
  (longest-unequal-adjacent-groups-subsq nums))