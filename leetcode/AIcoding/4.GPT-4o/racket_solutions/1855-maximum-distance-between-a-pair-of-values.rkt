(define (maxDistance nums1 nums2)
  (define (helper l r max-dist)
    (cond
      ((or (>= l (length nums1)) (>= r (length nums2))) max-dist)
      ((<= (list-ref nums1 l) (list-ref nums2 r))
       (helper l (+ r 1) (max max-dist (- r l)))
       )
      (else
       (helper (+ l 1) r max-dist))))
  (helper 0 0 0))