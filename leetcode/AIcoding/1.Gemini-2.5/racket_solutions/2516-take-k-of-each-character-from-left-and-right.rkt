(define (get-char-code c)
  (- (char->integer c) (char->integer #\a)))

(define (take-k-of-each-character-from-left-and-right s k)
  (let* ((n (string-length s))
         (total-counts (make-vector 3 0))) ; counts for 'a', 'b', 'c' in the whole string

    ;; Count total occurrences
    (for-each (lambda (char)
                (let ((idx (get-char-code char)))
                  (vector-set! total-counts idx (+ (vector-ref total-counts idx) 1))))
              (string->list s))

    (let ((total-a (vector-ref total-counts 0))
          (total-b (vector-ref total-counts 1))
          (total-c (vector-ref total-counts 2)))

      ;; Determine the actual k-requirements based on total availability.
      ;; If total_x < k, the requirement for character x is relaxed to total_x.
      ;; This interpretation matches the LeetCode examples.
      (let ((required-a (if (< total-a k) total-a k))
            (required-b (if (< total-b k) total-b k))
            (required-c (if (< total-c k) total-c k)))

        (let ((left-taken-counts (make-vector 3 0))
              (right-taken-counts (make-vector 3 0))
              (min-total-taken n) ; Initialize with max possible (taking whole string)
              (right-ptr n)) ; right_ptr is the index of the first character *not* taken from the right

          ;; Iterate through all possible lengths of the prefix taken from the left (left-len from 0 to n)
          (for ((left-len (in-range (+ n 1))))
            ;; If left-len > 0, add the character s[left-len-1] to left-taken-counts
            (when (> left-len 0)
              (let* ((char (string-ref s (- left-len 1)))
                     (idx (get-char-code char)))
                (vector-set! left-taken-counts idx (+ (vector-ref left-taken-counts idx) 1))))

            ;; Adjust the right_ptr to satisfy the combined conditions
            (let loop ()
              (when (and (> right-ptr left-len) ; Ensure left prefix and right suffix do not overlap
                         (or (< (+ (vector-ref left-taken-counts 0) (vector-ref right-taken-counts 0)) required-a)
                             (< (+ (vector-ref left-taken-counts 1) (vector-ref right-taken-counts 1)) required-b)
                             (< (+ (vector-ref left-taken-counts 2) (vector-ref right-taken-counts 2)) required-c)))
                ;; Take one more character from the right
                (set! right-ptr (- right-ptr 1))
                (let* ((char (string-ref s right-ptr))
                       (idx (get-char-code char)))
                  (vector-set! right-taken-counts idx (+ (vector-ref right-taken-counts idx) 1)))
                (loop)))

            ;; If the combined counts satisfy the requirements, update min-total-taken
            (when (and (>= (+ (vector-ref left-taken-counts 0) (vector-ref right-taken-counts 0)) required-a)
                       (>= (+ (vector-ref left-taken-counts 1) (vector-ref right-taken-counts 1)) required-b)
                       (>= (+ (vector-ref left-taken-counts 2) (vector-ref right-taken-counts 2)) required-c))
              (set! min-total-taken (min min-total-taken (+ left-len (- n right-ptr))))))

          ;; The problem guarantees that a solution always exists if k=0 (return 0) or if all characters are available.
          ;; If k > 0 and total_x = 0, then required_x = 0, so min-total-taken will always be <= n.
          min-total-taken)))))