(define (max-marked-indices nums)
  (define (helper nums1 nums2)
    (cond [(null? nums1) 0]
          [(null? nums2) 0]
          [(<= (car nums1) (car nums2))
           (add1 (helper (cdr nums1) (cdr nums2)))]
          [else (helper (cdr nums1) nums2)]))
  (define sorted (sort nums <))
  (define n (length sorted))
  (helper (take sorted (quotient n 2)) (drop sorted (quotient n 2))))