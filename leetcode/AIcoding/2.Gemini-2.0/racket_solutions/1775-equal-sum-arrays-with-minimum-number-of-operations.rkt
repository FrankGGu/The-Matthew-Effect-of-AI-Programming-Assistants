(define (minOperations nums1 nums2)
  (define (sum arr) (apply + arr))
  (define (max-ops arr1 arr2)
    (define sum1 (sum arr1))
    (define sum2 (sum arr2))
    (cond
      [(> sum1 sum2) (max-ops arr2 arr1)]
      [(= sum1 sum2) 0]
      [else
       (define diff (- sum2 sum1))
       (define arr1-sorted (sort arr1 >))
       (define arr2-sorted (sort arr2 <))
       (define ops 0)
       (define i 0)
       (define j 0)
       (let loop ([diff diff] [i i] [j j] [ops ops])
         (cond
           [(<= diff 0) ops]
           [(and (< i (length arr1-sorted)) (< j (length arr2-sorted)))
            (if (> (- (list-ref arr1-sorted i) 1) (- 6 (list-ref arr2-sorted j)))
                (loop (- diff (- (list-ref arr1-sorted i) 1)) (+ i 1) j (+ ops 1))
                (loop (- diff (- 6 (list-ref arr2-sorted j))) i (+ j 1) (+ ops 1)))]
           [(< i (length arr1-sorted))
            (loop (- diff (- (list-ref arr1-sorted i) 1)) (+ i 1) j (+ ops 1))]
           [(< j (length arr2-sorted))
            (loop (- diff (- 6 (list-ref arr2-sorted j))) i (+ j 1) (+ ops 1))]
           [else -1]))]))

  (if (> (* (length nums1) 6) (* (length nums2) 1))
      (max-ops nums1 nums2)
      (if (> (* (length nums2) 6) (* (length nums1) 1))
          (max-ops nums2 nums1)
          -1)))