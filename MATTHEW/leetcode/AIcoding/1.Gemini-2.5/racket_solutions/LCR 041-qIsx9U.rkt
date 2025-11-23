(require racket/list)

(define moving-average%
  (class object%
    (init-field size)
    (field [queue (make-deque)]
           [current-sum 0])

    (define/public (next val)
      ;; Add the new value to the back of the deque
      (deque-add-back! queue val)
      (set! current-sum (+ current-sum val))

      ;; If the deque size exceeds the window size,
      ;; remove the oldest value from the front
      (when (> (deque-length queue) size)
        (let ([oldest-val (deque-remove-front! queue)])
          (set! current-sum (- current-sum oldest-val))))

      ;; Calculate and return the current moving average
      (/ current-sum (deque-length queue)))))