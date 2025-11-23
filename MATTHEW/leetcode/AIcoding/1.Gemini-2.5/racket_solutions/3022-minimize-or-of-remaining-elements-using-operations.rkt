#lang racket

(define (minimize-or-of-remaining-elements-using-operations nums k)
  (define n (length nums))
  (define nums-vec (list->vector nums)) ; Convert to vector for O(1) access

  ;; Helper function to check if an OR sum of 'x' or less is achievable.
  ;; This means we can partition nums into 'm' segments such that m >= n - k,
  ;; and the bitwise AND of elements in each segment is a submask of 'x'.
  (define (check x)
    (let loop ((i 0)
               (current-and #xffffffff) ; Initialize with all bits set (for 32-bit integers)
               (segments 0))
      (if (= i n)
          ;; If we reached the end, we need to finalize the last segment.
          ;; If current-and is still #xffffffff, it means the last element itself formed a segment
          ;; and reset current-and. So 'segments' already counts it.
          ;; If current-and is not #xffffffff, it means we have an ongoing segment.
          ;; This ongoing segment must be a submask of x.
          ;; If it is, we add 1 to segments. If not, it's an invalid partition.
          (let ((final-segments (if (= current-and #xffffffff)
                                    segments
                                    (if (= (bitwise-and current-and x) current-and)
                                        (add1 segments)
                                        0)))) ; If the last segment is not a submask of x, it's impossible.
            (>= final-segments (- n k)))
          (let* ((num (vector-ref nums-vec i))
                 (next-and (bitwise-and current-and num)))
            ;; If next-and is a submask of x, we can form a segment here.
            (if (= (bitwise-and next-and x) next-and)
                (loop (add1 i)
                      #xffffffff ; Reset current-and to all-ones for the next segment
                      (add1 segments))
                (loop (add1 i)
                      next-and
                      segments))))))

  ;; Binary search for the minimum possible OR sum.
  (let* ((max-val (if (null? nums) 0 (apply bitwise-ior nums))) ; Upper bound for binary search
         (low 0)
         (high max-val)
         (ans max-val))
    (let loop ((l low) (h high) (res ans))
      (if (> l h)
          res
          (let ((mid (+ l (quotient (- h l) 2))))
            (if (check mid)
                (loop l (- mid 1) mid)
                (loop (+ l 1) h res)))))))