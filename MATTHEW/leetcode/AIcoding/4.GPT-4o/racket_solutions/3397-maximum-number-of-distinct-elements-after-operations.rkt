(define (maxDistinctElements nums k)
  (define (helper nums k)
    (define counts (make-hash))
    (for-each (lambda (x) (hash-set! counts x (+ 1 (hash-ref counts x 0)))) nums)
    (define unique-count (hash-count counts))
    (define available (hash-count (hash-filter (lambda (key value) (= value 1)) counts)))
    (if (<= k available)
        (+ unique-count k)
        (+ unique-count (- k available) (max 0 (- (hash-count counts) available)))))
  (helper nums k))

(maxDistinctElements '(1 2 3 4 5) 1) ; Example usage