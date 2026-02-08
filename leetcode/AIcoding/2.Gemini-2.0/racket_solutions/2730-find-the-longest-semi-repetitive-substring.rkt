(define (longest-semi-repetitive-substring s)
  (let* ((n (string-length s))
         (max-len 0))
    (for* ((i (in-range n)))
      (let loop ((j i) (diff 0))
        (cond
          ((= j n)
           (set! max-len (max max-len (- j i))))
          (else
           (let ((same? (and (> j i) (char=? (string-ref s j) (string-ref s (- j 1))))))
             (cond
               ((and same? (> diff 0))
                (set! max-len (max max-len (- j i))))
               (same?
                (loop (+ j 1) (+ diff 1)))
               (else
                (loop (+ j 1) diff))))))))
    max-len))