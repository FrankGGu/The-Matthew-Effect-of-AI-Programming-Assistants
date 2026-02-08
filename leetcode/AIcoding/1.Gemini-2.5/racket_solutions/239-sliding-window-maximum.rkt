(require data/deque)

(define (max-sliding-window nums k)
  (let* ((n (length nums))
         (result '())
         (dq (make-deque))) ; Stores indices

    (for ([i (in-range n)])
      (let ((current-num (list-ref nums i)))

        ;; Remove elements from the front of dq that are out of the current window
        (when (and (not (deque-empty? dq))
                   (< (deque-front dq) (- i k -1)))
          (deque-pop-front! dq))

        ;; Remove elements from the back of dq that are smaller than current-num
        (let loop-pop-back ()
          (when (and (not (deque-empty? dq))
                     (< (list-ref nums (deque-back dq)) current-num))
            (deque-pop-back! dq)
            (loop-pop-back)))

        ;; Add current index to the back of dq
        (deque-push-back! dq i)

        ;; If window is formed, add max to result
        (when (>= i (- k 1))
          (set! result (cons (list-ref nums (deque-front dq)) result)))))

    (reverse result)))