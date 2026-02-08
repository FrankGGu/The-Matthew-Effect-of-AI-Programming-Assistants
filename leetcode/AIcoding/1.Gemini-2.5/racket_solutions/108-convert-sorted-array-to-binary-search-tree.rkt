(struct TreeNode (val left right))

(define (sorted-array-to-bst nums)
  (define (build-bst current-list len)
    (if (zero? len)
        null
        (let* ((mid-idx (quotient len 2))
               (left-len mid-idx)
               (right-len (- len mid-idx 1)))
          (let-values (((left-part mid-val-and-right-part) (split-at current-list mid-idx)))
            (let* ((mid-val (car mid-val-and-right-part))
                   (right-part (cdr mid-val-and-right-part)))
              (TreeNode mid-val
                        (build-bst left-part left-len)
                        (build-bst right-part right-len)))))))

  (build-bst nums (length nums)))