(define (maximum-or nums k)
  (define n (length nums))
  (if (zero? n)
      0
      (begin
        ;; Calculate prefix ORs
        ;; prefix-ors[i] stores (nums[0] | ... | nums[i])
        (define prefix-ors
          (let loop ((idx 0) (current-or 0) (acc '()))
            (if (= idx n)
                (reverse acc)
                (let ((new-or (bitwise-ior current-or (list-ref nums idx))))
                  (loop (+ idx 1) new-or (cons new-or acc))))))

        ;; Calculate suffix ORs
        ;; suffix-ors[i] stores (nums[i] | ... | nums[n-1])
        (define suffix-ors
          (let loop ((idx (- n 1)) (current-or 0) (acc '()))
            (if (< idx 0)
                acc ; already in correct order (from right to left)
                (let ((new-or (bitwise-ior current-or (list-ref nums idx))))
                  (loop (- idx 1) new-or (cons new-or acc))))))

        ;; Iterate through each element, apply modification, and find max OR
        (let loop ((idx 0) (max-val 0))
          (if (= idx n)
              max-val
              (let* ((left-or (if (> idx 0) (list-ref prefix-ors (- idx 1)) 0))
                     (right-or (if (< idx (- n 1)) (list-ref suffix-ors (+ idx 1)) 0))
                     (current-num (list-ref nums idx))
                     (modified-num (* current-num (expt 2 k)))
                     (current-total-or (bitwise-ior left-or right-or modified-num)))
                (loop (+ idx 1) (max max-val current-total-or))))))))