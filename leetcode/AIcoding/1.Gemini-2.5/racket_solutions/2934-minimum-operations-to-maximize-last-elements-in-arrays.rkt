(define (min-operations-to-maximize-last-elements nums1 nums2)
  (define n (length nums1))

  (define (solve-list-based target1-last target2-last l1-prefix l2-prefix)
    (let loop ((current-l1 l1-prefix) (current-l2 l2-prefix) (swaps 0))
      (cond
        ((empty? current-l1) swaps)
        (else
         (let ((val1 (car current-l1))
               (val2 (car current-l2)))
           (cond
             ((and (<= val1 target1-last) (<= val2 target2-last))
              (loop (cdr current-l1) (cdr current-l2) swaps))
             ((and (<= val2 target1-last) (<= val1 target2-last))
              (loop (cdr current-l1) (cdr current-l2) (+ swaps 1)))
             (else
              +inf.0)))))))

  (define last1 (last nums1))
  (define last2 (last nums2))

  (define nums1-prefix (take nums1 (- n 1)))
  (define nums2-prefix (take nums2 (- n 1)))

  (define ans1 (solve-list-based last1 last2 nums1-prefix nums2-prefix))
  (define ans2 (solve-list-based last2 last1 nums1-prefix nums2-prefix))

  (define result (min ans1 ans2))

  (if (= result +inf.0)
      -1
      result))