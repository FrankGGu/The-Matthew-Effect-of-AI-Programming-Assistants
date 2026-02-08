(define (earliestSecondToMarkIndicesII timeSeries duration)
  (let loop ((i 0) (marked 0) (last-marked -1))
    (if (>= i (length timeSeries))
        marked
        (let ((current (vector-ref timeSeries i)))
          (if (or (< current last-marked) 
                  (< current (+ last-marked duration)))
              (loop (+ i 1) marked last-marked)
              (loop (+ i 1) (+ marked 1) current))))))

(define (earliestSecondToMarkIndices timeSeries duration)
  (earliestSecondToMarkIndicesII timeSeries duration))