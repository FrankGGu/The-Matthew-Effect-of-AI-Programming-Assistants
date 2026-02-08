(define (min-flips-mono-incr s)
  (let* ((n (string-length s)))
    (if (= n 0)
        0
        (let loop ((idx 0)
                   (zero-flips-so-far 0) ; min flips for prefix s[0...idx-1] to be all '0's
                   (one-flips-so-far 0))  ; min flips for prefix s[0...idx-1] to be monotone ending in '1'
          (if (= idx n)
              (min zero-flips-so-far one-flips-so-far)
              (let ((c (string-ref s idx)))
                (if (char=? c #\0)
                    ;; If current char is '0'
                    ;; To maintain all '0's: keep '0', no flip needed for current char.
                    ;; To maintain monotone ending in '1': current '0' must be flipped to '1'.
                    (loop (+ idx 1)
                          zero-flips-so-far
                          (+ (min zero-flips-so-far one-flips-so-far) 1))
                    ;; If current char is '1'
                    ;; To maintain all '0's: current '1' must be flipped to '0'.
                    ;; To maintain monotone ending in '1': keep '1', no flip needed for current char.
                    (loop (+ idx 1)
                          (+ zero-flips-so-far 1)
                          (min zero-flips-so-far one-flips-so-far)))))))))