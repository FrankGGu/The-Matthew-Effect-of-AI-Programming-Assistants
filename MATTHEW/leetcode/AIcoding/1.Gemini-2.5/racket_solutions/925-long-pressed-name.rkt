(define (is-long-pressed-name name typed)
  (let* ((n-len (string-length name))
         (t-len (string-length typed)))
    (let loop ((i 0) (j 0))
      (cond
        ((= j t-len) ; Typed string exhausted
         (= i n-len)) ; Return true if name string also exhausted

        ((and (< i n-len)
              (char=? (string-ref name i) (string-ref typed j)))
         (loop (+ i 1) (+ j 1))) ; Match: advance both pointers

        ((and (> j 0)
              (char=? (string-ref typed j) (string-ref typed (- j 1))))
         (loop i (+ j 1))) ; Long press: advance only typed pointer

        (else
         #f))))) ; Mismatch or invalid long press