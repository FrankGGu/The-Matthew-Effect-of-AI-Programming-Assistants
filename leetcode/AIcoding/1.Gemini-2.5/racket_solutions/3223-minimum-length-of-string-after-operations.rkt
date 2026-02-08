(define (minimum-length s)
  (let ((n (string-length s)))
    (let loop ((left 0) (right (- n 1)))
      (cond
        ;; If the pointers have crossed, the string is empty.
        ((> left right) 0)
        ;; If the pointers meet, a single character remains.
        ;; Per problem statement, operation cannot be performed if string has only one character.
        ((= left right) 1)
        ;; If characters at the current ends do not match, we cannot perform an operation.
        ;; The current length is the minimum.
        ((not (char=? (string-ref s left) (string-ref s right)))
         (+ (- right left) 1))
        ;; If characters at the current ends match, remove all consecutive matching characters
        ;; from both ends and recurse.
        (else
         (let ((current-char (string-ref s left)))
           ;; Advance the left pointer past all occurrences of current-char
           (let advance-left ((l left))
             (if (and (<= l right) (char=? (string-ref s l) current-char))
                 (advance-left (+ l 1))
                 ;; Once the condition fails, 'l' is the new effective left boundary
                 (let ((new-left l))
                   ;; Retreat the right pointer past all occurrences of current-char
                   (let retreat-right ((r right))
                     (if (and (>= r new-left) (char=? (string-ref s r) current-char))
                         (retreat-right (- r 1))
                         ;; Once the condition fails, 'r' is the new effective right boundary
                         ;; Continue the loop with the updated boundaries
                         (loop new-left r))))))))))))