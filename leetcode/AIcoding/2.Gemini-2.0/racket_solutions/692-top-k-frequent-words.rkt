(define (top-k-frequent words k)
  (define word-counts (make-hash))
  (for ([word words])
    (hash-update! word-counts word (λ (v) (+ v 1)) 1))

  (define min-heap (make-heap (λ (x y) (or (< (hash-ref word-counts (car x)) (hash-ref word-counts (car y)))
                                            (and (= (hash-ref word-counts (car x)) (hash-ref word-counts (car y)))
                                                 (string>? (car x) (car y)))))))

  (hash-for-each word-counts (λ (word count)
                               (heap-add! min-heap (cons word count))
                               (when (> (heap-count min-heap) k)
                                 (heap-remove-min! min-heap))))

  (let loop ([result '()])
    (if (heap-empty? min-heap)
        result
        (loop (cons (car (heap-remove-min! min-heap)) result))))

  (reverse (map car (filter (λ (x) (string? (car x))) (reverse (let loop ([result '()])
    (if (heap-empty? min-heap)
        result
        (loop (cons (heap-remove-min! min-heap) result)))))))))