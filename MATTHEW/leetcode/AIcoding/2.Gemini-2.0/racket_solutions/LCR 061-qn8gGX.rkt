(define (k-smallest-pairs nums1 nums2 k)
  (define n1 (length nums1))
  (define n2 (length nums2))

  (define heap (make-heap < #:key (lambda (x) (+ (list-ref nums1 (car x)) (list-ref nums2 (cdr x))))))

  (heap-add! heap (cons 0 0))

  (define result '())

  (for ([i (in-range (min k (* n1 n2)))])
    (if (heap-empty? heap)
        (void)
        (let* ([curr (heap-remove-min! heap)]
               [idx1 (car curr)]
               [idx2 (cdr curr)])
          (set! result (append result (list (list (list-ref nums1 idx1) (list-ref nums2 idx2)))))

          (when (< idx1 (- n1 1))
            (let ([next-pair (cons (+ idx1 1) idx2)])
              (unless (heap-member? heap next-pair equal?)
                (heap-add! heap next-pair))))

          (when (< idx2 (- n2 1))
            (let ([next-pair (cons idx1 (+ idx2 1))])
              (unless (heap-member? heap next-pair equal?)
                (heap-add! heap next-pair))))))))

  result)