(define (kth-smallest-product nums1 nums2 k)
  (let* ((n1-len (length nums1))
         (n2-len (length nums2))
         (nums1-vec (list->vector nums1)) ; Convert to vector for O(1) access
         (nums2-vec (list->vector nums2)) ; Convert to vector for O(1) access
         (min-prod -10000000000) ; -10^5 * 10^5 = -10^10
         (max-prod 10000000000)) ; 10^5 * 10^5 = 10^10

    ; Helper for ceil division: ceil(a / b) for integers a, b (b != 0)
    (define (ceil-div a b)
      (let ((q (quotient a b))
            (r (remainder a b)))
        (if (zero? r)
            q
            (if (> (* a b) 0) ; a and b have the same sign
                (+ q 1)
                q)))) ; a and b have different signs

    ; Finds the count of elements in a sorted vector 'arr' that are less than or equal to 'val'.
    ; This is equivalent to finding the index of the first element strictly greater than 'val'.
    (define (upper-bound arr val)
      (let loop ((low 0) (high n2-len))
        (if (< low high)
            (let ((mid (+ low (quotient (- high low) 2))))
              (if (<= (vector-ref arr mid) val)
                  (loop (+ mid 1) high)
                  (loop low mid)))
            low)))

    ; Finds the index of the first element in a sorted vector 'arr' that is greater than or equal to 'val'.
    (define (lower-bound arr val)
      (let loop ((low 0) (high n2-len))
        (if (< low high)
            (let ((mid (+ low (quotient (- high low) 2))))
              (if (< (vector-ref arr mid) val)
                  (loop (+ mid 1) high)
                  (loop low mid)))
            low)))

    ; Counts how many products nums1[i] * nums2[j] are less than or equal to 'target'.
    (define (count-le target)
      (let loop ((idx1 0) (count 0))
        (if (= idx1 n1-len)
            count
            (let* ((n1 (vector-ref nums1-vec idx1))
                   (new-count 0))
              (cond
                ((= n1 0)
                 ; If n1 is 0, product is 0. If target >= 0, all n2 result in <= target. Otherwise, none.
                 (set! new-count (if (>= target 0) n2-len 0)))
                ((> n1 0)
                 ; If n1 > 0, n1 * n2 <= target implies n2 <= target / n1.
                 ; We need to count n2 values in nums2-vec that are <= (quotient target n1).
                 (set! new-count (upper-bound nums2-vec (quotient target n1))))
                ((< n1 0)
                 ; If n1 < 0, n1 * n2 <= target implies n2 >= target / n1 (inequality flips).
                 ; We need to count n2 values in nums2-vec that are >= ceil(target / n1).
                 ; The count of elements >= val is (total length) - (index of first element >= val).
                 (let ((val (ceil-div target n1)))
                   (set! new-count (- n2-len (lower-bound nums2-vec val))))))
              (loop (+ idx1 1) (+ count new-count)))))))

    ; Binary search for the Kth smallest product
    (let loop ((low min-prod) (high max-prod) (ans max-prod))
      (if (<= low high)
          (let ((mid (+ low (quotient (- high low) 2))))
            (if (>= (count-le mid) k)
                ; If count of products <= mid is >= k, then mid could be our answer, or the answer is smaller.
                (loop low (- mid 1) mid)
                ; If count of products <= mid is < k, then mid is too small. We need a larger product.
                (loop (+ mid 1) high ans)))
          ans))))