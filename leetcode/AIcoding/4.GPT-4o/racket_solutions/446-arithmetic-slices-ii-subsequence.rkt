(define (numberOfArithmeticSlices A)
  (define n (length A))
  (define dp (make-vector n (make-vector n 0)))
  (define count 0)

  (for ([i (in-range n)]
        [j (in-range i)]
        #:when (> i j))
    (for ([k (in-range j)])
      (let ((diff (- (vector-ref A i) (vector-ref A j))))
        (when (and (not (= diff 0)) 
                   (<= (+ (vector-ref A j) diff) (vector-ref A (- i 1))))
          (let ((prev-count (vector-ref (vector-ref dp j) diff)))
            (vector-set! (vector-ref dp i) diff (+ prev-count 1))
            (set! count (+ count prev-count)))))))

  count)