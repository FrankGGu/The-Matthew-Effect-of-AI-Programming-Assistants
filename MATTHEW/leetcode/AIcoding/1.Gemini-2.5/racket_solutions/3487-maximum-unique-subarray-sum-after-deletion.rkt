(define (maximum-unique-subarray-sum-after-deletion nums)
  (let* ([n (length nums)]
         [current-left 0]
         [current-sum-val 0]
         [current-max-sum 0]
         [current-seen (make-hash)]) ; Hash table to store elements in the current window

    (for ([right-idx (in-range n)])
      (let ([num-at-right (list-ref nums right-idx)])

        ; Shrink the window from the left if the current element is already in the window
        (let loop-shrink ()
          (when (hash-has-key? current-seen num-at-right)
            (let ([left-val (list-ref nums current-left)])
              (hash-remove! current-seen left-val)
              (set! current-sum-val (- current-sum-val left-val))
              (set! current-left (+ current-left 1)))
            (loop-shrink))) ; Continue shrinking if num-at-right is still a duplicate

        ; Expand the window by adding the current element from the right
        (set! current-sum-val (+ current-sum-val num-at-right))
        (hash-set! current-seen num-at-right #t)

        ; Update the maximum unique subarray sum found so far
        (set! current-max-sum (max current-max-sum current-sum-val))))

    current-max-sum))