(define (max-score nums1 nums2 k)
  (define n (vector-length nums1))
  (define pairs (make-vector n))
  (for ([i (in-range n)])
    (vector-set! pairs i (cons (vector-ref nums1 i) (vector-ref nums2 i)))))

  (define sorted-pairs (sort pairs (lambda (a b) (> (cdr a) (cdr b)))))

  (define min-heap (make-heap < #:key car))
  (define current-sum 0)
  (for ([i (in-range k)])
    (heap-add! min-heap (car (vector-ref sorted-pairs i)))
    (set! current-sum (+ current-sum (car (vector-ref sorted-pairs i)))))

  (define max-score-val (* current-sum (cdr (vector-ref sorted-pairs (- k 1)))))

  (for ([i (in-range k n)])
    (when (< i n)
      (let ([current-min (heap-remove-min! min-heap)])
        (set! current-sum (- current-sum current-min))
        (set! current-sum (+ current-sum (car (vector-ref sorted-pairs i))))
        (heap-add! min-heap (car (vector-ref sorted-pairs i)))
        (set! max-score-val (max max-score-val (* current-sum (cdr (vector-ref sorted-pairs (- k 1)))))))))

  max-score-val)