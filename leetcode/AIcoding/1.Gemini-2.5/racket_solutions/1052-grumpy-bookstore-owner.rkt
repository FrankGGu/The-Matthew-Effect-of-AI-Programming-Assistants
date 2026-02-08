(define (max-satisfied customers grumpy minutes)
  (let* ((n (vector-length customers))
         (base-satisfied 0)
         (grumpy-customers-to-save (make-vector n 0)))

    (for ([i (in-range n)])
      (if (= (vector-ref grumpy i) 0)
          (set! base-satisfied (+ base-satisfied (vector-ref customers i)))
          (vector-set! grumpy-customers-to-save i (vector-ref customers i))))

    (let* ((current-window-sum 0)
           (max-additional-satisfied 0))

      (for ([i (in-range (min n minutes))])
        (set! current-window-sum (+ current-window-sum (vector-ref grumpy-customers-to-save i))))

      (set! max-additional-satisfied current-window-sum)

      (for ([i (in-range minutes n)])
        (set! current-window-sum
              (- (+ current-window-sum (vector-ref grumpy-customers-to-save i))
                 (vector-ref grumpy-customers-to-save (- i minutes))))
        (set! max-additional-satisfied (max max-additional-satisfied current-window-sum)))

      (+ base-satisfied max-additional-satisfied))))