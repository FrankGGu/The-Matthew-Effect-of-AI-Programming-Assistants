(define (minimum-total-cost nums1 nums2)
  (let loop ([i 0] [cost 0] [freq (make-hash)] [max-freq 0] [max-val 0] [total 0])
    (cond
      [(= i (length nums1)) (if (>= (* max-freq 2) total) (+ cost max-val)) cost cost)]
      [(= (list-ref nums1 i) (list-ref nums2 i))
       (let* ([val (list-ref nums1 i)]
              [new-freq (add1 (hash-ref freq val 0))])
         (loop (add1 i)
               (+ cost i)
               (hash-set freq val new-freq)
               (max max-freq new-freq)
               (if (> new-freq max-freq) val max-val)
               (add1 total)))]
      [else (loop (add1 i) cost freq max-freq max-val total)])))