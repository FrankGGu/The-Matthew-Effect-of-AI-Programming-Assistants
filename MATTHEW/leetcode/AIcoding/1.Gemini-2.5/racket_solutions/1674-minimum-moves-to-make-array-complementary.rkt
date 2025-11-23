(define (min-moves-to-make-array-complementary nums limit)
  (let* ((n (length nums))
         (nums-vec (list->vector nums))
         (num-pairs (/ n 2))
         (max-sum-val (* 2 limit))
         (diff-array-size (+ max-sum-val 2)) ; For indices up to max-sum-val + 1
         (diff (make-vector diff-array-size 0)))

    (for ((i (in-range num-pairs)))
      (let* ((a (vector-ref nums-vec i))
             (b (vector-ref nums-vec (- n 1 i)))
             (x (min a b))
             (y (max a b))
             (sum-ab (+ a b)))

        (vector-set! diff 2 (+ (vector-ref diff 2) 2))
        (vector-set! diff (+ max-sum-val 1) (- (vector-ref diff (+ max-sum-val 1)) 2))

        (vector-set! diff (+ 1 x) (- (vector-ref diff (+ 1 x)) 1))
        (vector-set! diff (+ limit y 1) (+ (vector-ref diff (+ limit y 1)) 1))

        (vector-set! diff sum-ab (- (vector-ref diff sum-ab) 1))
        (vector-set! diff (+ sum-ab 1) (+ (vector-ref diff (+ sum-ab 1)) 1))))

    (let ((min-total-moves (+ (* 2 num-pairs) 1))
          (current-total-moves 0))
      (for ((s (in-range 2 (+ max-sum-val 1))))
        (set! current-total-moves (+ current-total-moves (vector-ref diff s)))
        (when (< current-total-moves min-total-moves)
          (set! min-total-moves current-total-moves)))
      min-total-moves)))