(define (find-median-sorted-arrays nums1 nums2)
  (let* ((m (vector-length nums1))
         (n (vector-length nums2))
         (total-length (+ m n)))

    ;; Helper function to find the k-th smallest element (1-indexed k)
    ;; It operates on sub-vectors defined by start and end indices.
    (define (find-kth-element arr1 start1 end1 arr2 start2 end2 k)
      (let* ((len1 (- end1 start1))
             (len2 (- end2 start2)))

        ;; Ensure arr1 is the shorter (or equal length) array to simplify logic
        ;; by calling itself with swapped arguments if arr1 is longer.
        (when (> len1 len2)
          (find-kth-element arr2 start2 end2 arr1 start1 end1 k))

        (cond
          ;; If arr1 is empty, the k-th element must be in arr2
          ((= len1 0) (vector-ref arr2 (+ start2 k -1)))
          ;; If k is 1, return the minimum of the first elements
          ((= k 1) (min (vector-ref arr1 start1) (vector-ref arr2 start2)))
          ;; Recursive step
          (else
           ;; p1: number of elements to consider from arr1
           ;; p2: number of elements to consider from arr2
           ;; p1 + p2 = k
           (let* ((p1 (min (quotient k 2) len1))
                  (p2 (- k p1))
                  (val1 (vector-ref arr1 (+ start1 p1 -1)))
                  (val2 (vector-ref arr2 (+ start2 p2 -1))))

             (cond
               ((< val1 val2)
                (find-kth-element arr1 (+ start1 p1) end1 arr2 start2 end2 (- k p1)))
               ((> val1 val2)
                (find-kth-element arr1 start1 end1 arr2 (+ start2 p2) end2 (- k p2)))
               ;; If val1 = val2, then val1 (or val2) is the k-th element
               (else val1)))))))

    (if (odd? total-length)
        ;; Odd total length: median is the (total-length / 2 + 1)-th element
        (find-kth-element nums1 0 m nums2 0 n (+ (quotient total-length 2) 1))
        ;; Even total length: median is the average of (total-length / 2)-th and (total-length / 2 + 1)-th elements
        (let ((mid1 (find-kth-element nums1 0 m nums2 0 n (quotient total-length 2)))
              (mid2 (find-kth-element nums1 0 m nums2 0 n (+ (quotient total-length 2) 1))))
          (/ (+ (exact->inexact mid1) (exact->inexact mid2)) 2.0))))))