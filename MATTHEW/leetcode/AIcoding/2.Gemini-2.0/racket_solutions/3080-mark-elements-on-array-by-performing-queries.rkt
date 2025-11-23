(define (mark-elements queries n)
  (let ((marked (make-vector n #f)))
    (for ([q queries])
      (let ([index (car q)]
            [value (cdr q)])
        (when (and (>= index 0) (< index n))
          (vector-set! marked index #t))))
    marked))

(define (count-marked marked)
  (let loop ([i 0] [count 0])
    (if (= i (vector-length marked))
        count
        (loop (+ i 1) (if (vector-ref marked i) (+ count 1) count)))))

(define (mark-elements-leetcode queries n)
  (let ([marked (mark-elements queries n)])
    (count-marked marked)))