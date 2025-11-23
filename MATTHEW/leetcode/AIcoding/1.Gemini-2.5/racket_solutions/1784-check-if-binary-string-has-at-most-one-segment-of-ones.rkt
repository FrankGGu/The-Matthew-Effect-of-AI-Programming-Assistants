(define (check-if-binary-string-has-at-most-one-segment-of-ones s)
  (let loop ((idx 0)
             (seen-one #f)
             (seen-zero-after-one #f))
    (if (= idx (string-length s))
        #t
        (let ((char (string-ref s idx)))
          (cond
            ((char=? char #\1)
             (if seen-zero-after-one
                 #f
                 (loop (+ idx 1) #t seen-zero-after-one)))
            ((char=? char #\0)
             (if seen-one
                 (loop (+ idx 1) seen-one #t)
                 (loop (+ idx 1) seen-one seen-zero-after-one))))))))