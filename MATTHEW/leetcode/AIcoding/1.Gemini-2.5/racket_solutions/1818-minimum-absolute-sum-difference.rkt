(define (min-absolute-sum-difference nums1 nums2)
  (define MOD 1000000007)
  (define n (length nums1))
  (define nums1-vec (list->vector nums1))
  (define nums2-vec (list->vector nums2))

  (define sorted-nums1-vec (vector-sort < (vector-copy nums1-vec)))

  (define total-sum 0)
  (define max-reduction 0)

  (define (find-closest-diff sorted-vec target)
    (let* ((len (vector-length sorted-vec))
           (left 0)
           (right (- len 1)))
      (cond
        ((zero? len) +inf.0)
        ((<= target (vector-ref sorted-vec 0))
         (abs (- (vector-ref sorted-vec 0) target)))
        ((>= target (vector-ref sorted-vec (- len 1)))
         (abs (- (vector-ref sorted-vec (- len 1)) target)))
        (else
         (let loop ((l left) (r right))
           (if (<= (- r l) 1)
               (min (abs (- (vector-ref sorted-vec l) target))
                    (abs (- (vector-ref sorted-vec r) target)))
               (let ((mid (+ l (quotient (- r l) 2))))
                 (cond
                   ((= (vector-ref sorted-vec mid) target) 0)
                   ((< (vector-ref sorted-vec mid) target) (loop mid r))
                   (else (loop l mid))))))))))

  (for ([i (in-range n)])
    (let* ((n1-val (vector-ref nums1-vec i))
           (n2-val (vector-ref nums2-vec i))
           (current-diff (abs (- n1-val n2-val)))
           (closest-val-diff (find-closest-diff sorted-nums1-vec n2-val)))
      (set! total-sum (+ total-sum current-diff))
      (set! max-reduction (max max-reduction (- current-diff closest-val-diff)))))

  (modulo (- total-sum max-reduction) MOD))