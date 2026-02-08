(define (find-relative-ranks scores)
  (let* ((n (length scores))
         (indexed-scores (map (lambda (score index) (list score index))
                              scores
                              (range n)))
         (sorted-indexed-scores (sort indexed-scores
                                      (lambda (a b) (> (car a) (car b)))))
         (result-vec (make-vector n)))

    (for-each (lambda (item rank-idx)
                (let* ((original-idx (cadr item))
                       (rank-str (cond
                                   ((= rank-idx 0) "Gold Medal")
                                   ((= rank-idx 1) "Silver Medal")
                                   ((= rank-idx 2) "Bronze Medal")
                                   (else (number->string (+ rank-idx 1))))))
                  (vector-set! result-vec original-idx rank-str)))
              sorted-indexed-scores
              (range n))

    (vector->list result-vec)))