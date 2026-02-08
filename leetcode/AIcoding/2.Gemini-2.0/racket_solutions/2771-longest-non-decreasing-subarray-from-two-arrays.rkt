(define (longest-non-decreasing-subarray1 nums1 nums2)
  (define n (vector-length nums1))
  (define (solve i prev1 prev2 dp1 dp2)
    (cond
      [(>= i n) 0]
      [(and (vector-ref dp1 i) (>= (vector-ref dp1 i) prev1)) (vector-ref dp1 i)]
      [(and (vector-ref dp2 i) (>= (vector-ref dp2 i) prev2)) (vector-ref dp2 i)]
      [else
       (define ans 0)
       (when (>= (vector-ref nums1 i) prev1)
         (define res (+ 1 (solve (+ i 1) (vector-ref nums1 i) 0 dp1 dp2)))
         (set! ans (max ans res)))
       (when (>= (vector-ref nums2 i) prev1)
         (define res (+ 1 (solve (+ i 1) (vector-ref nums2 i) 0 dp1 dp2)))
         (set! ans (max ans res)))
       (when (>= (vector-ref nums1 i) prev2)
         (define res (+ 1 (solve (+ i 1) (vector-ref nums1 i) 0 dp1 dp2)))
         (set! ans (max ans res)))
       (when (>= (vector-ref nums2 i) prev2)
         (define res (+ 1 (solve (+ i 1) (vector-ref nums2 i) 0 dp1 dp2)))
         (set! ans (max ans res)))
       (cond
         [(>= (vector-ref nums1 i) prev1) (vector-set! dp1 i ans)]
         [(>= (vector-ref nums2 i) prev2) (vector-set! dp2 i ans)])
       ans]))
  (define dp1 (make-vector n #f))
  (define dp2 (make-vector n #f))
  (solve 0 0 0 dp1 dp2))

(define (longest-non-decreasing-subarray nums1 nums2)
  (define n (vector-length nums1))
  (define dp (make-vector n 0))
  (define dp2 (make-vector n 0))
  (vector-set! dp 0 1)
  (vector-set! dp2 0 1)
  (define ans 1)
  (for ([i (in-range 1 n)])
    (define cur1 (vector-ref nums1 i))
    (define cur2 (vector-ref nums2 i))
    (define prev1 (vector-ref nums1 (- i 1)))
    (define prev2 (vector-ref nums2 (- i 1)))
    (define temp (vector-ref dp i))
    (define temp2 (vector-ref dp2 i))
    (cond
      [(>= cur1 prev1) (vector-set! dp i (+ 1 (vector-ref dp (- i 1))))]
      [else (vector-set! dp i 1)])
    (cond
      [(>= cur2 prev2) (vector-set! dp2 i (+ 1 (vector-ref dp2 (- i 1))))]
      [else (vector-set! dp2 i 1)])
    (cond
      [(>= cur1 prev2) (set! temp (max temp (+ 1 (vector-ref dp2 (- i 1)))))]
      [else (set! temp (max temp 1))])
    (cond
      [(>= cur2 prev1) (set! temp2 (max temp2 (+ 1 (vector-ref dp (- i 1)))))]
      [else (set! temp2 (max temp2 1))])
    (vector-set! dp i (max (vector-ref dp i) temp))
    (vector-set! dp2 i (max (vector-ref dp2 i) temp2))
    (set! ans (max ans (vector-ref dp i) (vector-ref dp2 i))))
  ans)