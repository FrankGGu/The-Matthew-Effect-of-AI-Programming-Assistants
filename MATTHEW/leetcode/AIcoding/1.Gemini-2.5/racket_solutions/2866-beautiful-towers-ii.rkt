(define (maximum-beautiful-towers heights)
  (define n (length heights))
  (define left-sums (make-vector n 0))
  (define right-sums (make-vector n 0))

  ;; Calculate left-sums
  ;; left-sums[i] represents the maximum sum of a non-decreasing tower subarray ending at index i,
  ;; where each element maxHeights[j] <= heights[j].
  (let loop-left ((i 0) (stack '()) (current-total-sum 0))
    (when (< i n)
      (define h_i (list-ref heights i))
      (let loop-pop ((current-stack stack) (segment-start-idx i) (current-sum current-total-sum))
        (if (and (not (null? current-stack)) (>= (cdr (car current-stack)) h_i))
            ;; Pop elements from stack that are taller than or equal to h_i
            ;; and subtract their contribution from current-sum.
            ;; The segment-start-idx is extended to the left.
            (let* ((prev-segment-start (car (car current-stack)))
                   (prev-segment-height (cdr (car current-stack)))
                   (new-current-sum (- current-sum (* prev-segment-height (- segment-start-idx prev-segment-start)))))
              (loop-pop (cdr current-stack) prev-segment-start new-current-sum))
            ;; After popping, add the contribution of the new segment [segment-start-idx, i]
            ;; with height h_i.
            (let* ((new-current-sum (+ current-sum (* h_i (+ (- i segment-start-idx) 1))))
                   (new-stack (cons (cons segment-start-idx h_i) current-stack)))
              (vector-set! left-sums i new-current-sum)
              (loop-left (+ i 1) new-stack new-current-sum))))))

  ;; Calculate right-sums
  ;; right-sums[i] represents the maximum sum of a non-increasing tower subarray starting at index i,
  ;; where each element maxHeights[j] <= heights[j].
  (let loop-right ((i (- n 1)) (stack '()) (current-total-sum 0))
    (when (>= i 0)
      (define h_i (list-ref heights i))
      (let loop-pop ((current-stack stack) (segment-end-idx i) (current-sum current-total-sum))
        (if (and (not (null? current-stack)) (>= (cdr (car current-stack)) h_i))
            ;; Pop elements from stack that are taller than or equal to h_i
            ;; and subtract their contribution from current-sum.
            ;; The segment-end-idx is extended to the right.
            (let* ((prev-segment-end (car (car current-stack)))
                   (prev-segment-height (cdr (car current-stack)))
                   (new-current-sum (- current-sum (* prev-segment-height (- prev-segment-end segment-end-idx)))))
              (loop-pop (cdr current-stack) prev-segment-end new-current-sum))
            ;; After popping, add the contribution of the new segment [i, segment-end-idx]
            ;; with height h_i.
            (let* ((new-current-sum (+ current-sum (* h_i (+ (- segment-end-idx i) 1))))
                   (new-stack (cons (cons segment-end-idx h_i) current-stack)))
              (vector-set! right-sums i new-current-sum)
              (loop-right (- i 1) new-stack new-current-sum))))))

  ;; Calculate the maximum total sum
  ;; For each index i, consider it as the peak.
  ;; The total sum is left_sums[i] + right_sums[i] - heights[i] (since heights[i] is counted twice).
  (define max-total-sum 0)
  (for ([i (in-range n)])
    (define current-total (+ (vector-ref left-sums i) (vector-ref right-sums i) (- (list-ref heights i))))
    (set! max-total-sum (max max-total-sum current-total)))
  max-total-sum)