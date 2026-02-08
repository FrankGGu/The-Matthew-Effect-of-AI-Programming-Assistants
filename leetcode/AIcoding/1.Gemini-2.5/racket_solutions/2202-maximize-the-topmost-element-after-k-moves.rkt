(define (maximize-topmost-element-after-k-moves nums k)
  (let* ((n (length nums)))
    (cond
      ((zero? n) -1) ; Handle empty array, though constraints usually state n >= 1
      ((zero? k) (car nums)) ; No moves, topmost is the first element
      ((= n k) -1) ; If k equals n, all elements are removed, and no moves left to put any back. Array is empty.
      (else
       (let ((max-val -1))
         ;; Case 1: An element nums[i] remains at the top without being removed and put back.
         ;; To have nums[i] at the top, we must remove 'i' elements from the front. This uses 'i' moves.
         ;; We have 'k - i' moves remaining.
         ;; For nums[i] to remain at the top, 'k - i' must be an even number (including 0).
         ;; If 'k - i' is positive and even, we can remove nums[i] and put it back (k-i)/2 times.
         ;; The index 'i' can go from 0 up to min(k, n-1).
         (for ([i (in-range 0 (add1 (min k (- n 1))))])
           (when (even? (- k i))
             (set! max-val (max max-val (list-ref nums i)))))

         ;; Case 2: An element nums[j] was removed and then put back at the top.
         ;; Let 'x' be the number of elements initially removed from the front (nums[0]...nums[x-1]).
         ;; This uses 'x' moves. We have 'k - x' moves remaining.
         ;; If 'k - x' is odd and positive, we can use 1 move to put back one of the removed elements.
         ;; We would choose the maximum among nums[0]...nums[x-1].
         ;; After putting it back, we have 'k - x - 1' moves remaining, which is an even number.
         ;; This allows the chosen element to stay at the top.
         ;; The number of elements 'x' can go from 1 up to min(k, n).
         (for ([x (in-range 1 (add1 (min k n)))])
           (when (odd? (- k x))
             (set! max-val (max max-val (apply max (take nums x))))))
         max-val))))