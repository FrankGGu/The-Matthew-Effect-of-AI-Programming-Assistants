(define (num-subarray-product-less-than-k nums k)
  (if (<= k 1)
      0
      (let* ([n (length nums)]
             [arr (list->vector nums)])
        (let loop ([left 0]
                   [prod 1]
                   [count 0]
                   [right 0])
          (if (= right n)
              count
              (let* ([num-r (vector-ref arr right)])
                ;; Expand window
                (let ([current-prod (* prod num-r)])
                  ;; Shrink window if necessary
                  (let inner-loop ([current-left left]
                                   [current-prod-after-shrink current-prod])
                    (if (>= current-prod-after-shrink k)
                        (let* ([num-l (vector-ref arr current-left)]
                               [next-prod-after-shrink (/ current-prod-after-shrink num-l)])
                          (inner-loop (+ current-left 1) next-prod-after-shrink))
                        ;; Window is valid: [current-left ... right]
                        ;; Add (right - current-left + 1) to count
                        (let ([new-count (+ count (- right current-left) 1)])
                          ;; Move right pointer
                          (loop current-left
                                current-prod-after-shrink
                                new-count
                                (+ right 1)))))))))))