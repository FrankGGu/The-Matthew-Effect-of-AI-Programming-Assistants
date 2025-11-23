(define (minOperations nums1 nums2)
  (define total1 (apply + nums1))
  (define total2 (apply + nums2))
  (define diff (abs (- total1 total2)))
  (if (= diff 0)
      0
      (define max-change (+ 6 (min (length nums1) (length nums2))))
      (define (helper change)
        (if (= change 0)
            0
            (let loop ([i 1] [count 0])
              (cond
                [(> i max-change) (if (> change 0) +inf.0 count)]
                [else (loop (+ i 1) (min count (if (>= change i) (+ count 1) count)))]))))
      (helper diff))))

(minOperations '(1 2 3) '(4 5 6))