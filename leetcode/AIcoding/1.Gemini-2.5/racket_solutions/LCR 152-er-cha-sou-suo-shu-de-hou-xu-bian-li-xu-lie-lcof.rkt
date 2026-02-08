(define (verify-postorder postorder)
  (define n (length postorder))

  (if (<= n 1)
      #t
      (let ((arr (list->vector postorder)))
        (define (helper start end)
          ;; Base case: an empty or single-element sub-sequence is always a valid BST postorder traversal.
          (if (<= start end)
              #t
              (let* ((root-val (vector-ref arr end)))
                ;; Find the split point for the left and right subtrees.
                ;; 'i' will be the index of the first element in arr[start...end-1]
                ;; that is greater than or equal to root-val.
                ;; Elements arr[start...i-1] are part of the left subtree (should be < root-val).
                ;; Elements arr[i...end-1] are part of the right subtree (should be > root-val).
                (let loop-i ((i start))
                  (if (and (< i end) (< (vector-ref arr i) root-val))
                      (loop-i (+ i 1))
                      ;; 'i' is now the split index.
                      (let ((split-idx i))
                        ;; Verify the right subtree part:
                        ;; All elements from 'split-idx' to 'end-1' must be greater than root-val.
                        (let loop-j ((j split-idx))
                          (if (and (< j end) (> (vector-ref arr j) root-val))
                              (loop-j (+ j 1))
                              ;; If 'j' is not equal to 'end', it means we found an element
                              ;; in the supposed right subtree part that is not greater than root-val.
                              ;; This violates BST property, so it's an invalid sequence.
                              (if (not (= j end))
                                  #f
                                  ;; If the split is valid, recursively check the left and right subtrees.
                                  ;; Left subtree: arr[start ... split-idx - 1]
                                  ;; Right subtree: arr[split-idx ... end - 1]
                                  (and (helper start (- split-idx 1))
                                       (helper split-idx (- end 1))))))))))))
        ;; Initial call to the helper function for the entire sequence.
        (helper 0 (- n 1)))))