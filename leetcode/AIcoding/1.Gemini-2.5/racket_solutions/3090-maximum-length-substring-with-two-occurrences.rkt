(define (maximum-length-substring s)
  (let* ((n (string-length s))
         (counts (make-vector 26 0)) ; Frequency map for 'a' through 'z'
         (left 0)
         (max-len 0))
    (for ([right (in-range n)])
      (let* ((char-right (string-ref s right))
             (idx-right (- (char->integer char-right) (char->integer #\a))))

        ;; Increment count for the character at the right pointer
        (vector-set! counts idx-right (+ (vector-ref counts idx-right) 1))

        ;; If the count for the current character exceeds 2, shrink the window from the left
        (let loop ()
          (when (> (vector-ref counts idx-right) 2)
            (let* ((char-left (string-ref s left))
                   (idx-left (- (char->integer char-left) (char->integer #\a))))
              ;; Decrement count for the character at the left pointer
              (vector-set! counts idx-left (- (vector-ref counts idx-left) 1))
              ;; Move the left pointer
              (set! left (+ left 1)))
            (loop))) ; Continue shrinking if the current character's count is still > 2

        ;; Update the maximum length of the valid substring
        (set! max-len (max max-len (+ (- right left) 1)))))
    max-len))