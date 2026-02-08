(define/contract (advantage-shuffle nums1 nums2)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums1)]
         [sorted-nums1 (sort nums1 <)]
         [sorted-nums2 (sort (for/list ([i (in-range n)]) (cons (list-ref nums2 i) i)) < #:key car)]
         [res (make-vector n -1)]
         [left 0]
         [right (sub1 n)])
    (for ([pair sorted-nums2] [num sorted-nums1])
      (if (> num (car pair))
          (begin
            (vector-set! res (cdr pair) num)
          (begin
            (vector-set! res (cdr (list-ref sorted-nums2 right)) num)
            (set! right (sub1 right)))))
    (vector->list res)))