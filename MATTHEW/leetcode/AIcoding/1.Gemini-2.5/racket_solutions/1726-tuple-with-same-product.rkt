(define (tuple-with-same-product nums)
  (let* ((n (length nums))
         (product-counts (make-hash))
         (total-tuples 0))

    (for* ((i (in-range n))
           (j (in-range (+ i 1) n)))
      (let ((product (* (list-ref nums i) (list-ref nums j))))
        (hash-set! product-counts product (+ (hash-ref product-counts product 0) 1))))

    (for-each (lambda (k)
                (when (>= k 2)
                  (set! total-tuples (+ total-tuples (* k (- k 1) 4)))))
              (hash-values product-counts))

    total-tuples))