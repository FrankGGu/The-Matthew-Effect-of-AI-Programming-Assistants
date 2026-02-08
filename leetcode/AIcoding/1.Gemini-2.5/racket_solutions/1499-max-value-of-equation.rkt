(define (max-value-of-equation points k)
  (let* ((n (length points))
         (points-vec (list->vector points))
         (max-val (- (expt 2 62))) ; Initialize with a very small integer
         ; Deque implementation using a vector and head/tail pointers
         (deque-vec (make-vector n #f)) ; Stores (list x (y-x))
         (head 0)
         (tail 0))

    ; Helper functions for deque
    (define (deque-empty?) (= head tail))
    (define (deque-front) (vector-ref deque-vec head))
    (define (deque-back) (vector-ref deque-vec (- tail 1)))
    (define (deque-pop-front!) (set! head (+ head 1)))
    (define (deque-pop-back!) (set! tail (- tail 1)))
    (define (deque-push-back! item)
      (vector-set! deque-vec tail item)
      (set! tail (+ tail 1)))

    (for ([j (in-range n)])
      (let* ((pj (vector-ref points-vec j))
             (xj (car pj))
             (yj (cadr pj)))

        ; 1. Remove elements from the front of the deque that are out of the window.
        ;    Condition: xi < xj - k
        (while (and (not (deque-empty?))
                    (< (car (deque-front)) (- xj k)))
          (deque-pop-front!))

        ; 2. If the deque is not empty, calculate the current maximum value.
        ;    Equation: (yj + xj) + (yi - xi)
        (when (not (deque-empty?))
          (let* ((front-item (deque-front))
                 (val-front (cadr front-item))) ; val-front is (yi - xi)
            (set! max-val (max max-val (+ (+ yj xj) val-front)))))

        ; 3. Add the current point to the deque, maintaining the monotonic property.
        ;    We want to keep (yi - xi) values in decreasing order in the deque.
        (let ((current-val (- yj xj))) ; current-val is (yj - xj)
          (while (and (not (deque-empty?))
                      (<= (cadr (deque-back)) current-val))
            (deque-pop-back!))
          (deque-push-back! (list xj current-val)))))
    max-val))