(define (min-window s t)
  (let* ([target (make-hash)]
         [required (for/sum ([c t])
                     (hash-update! target c add1 (λ () 0))
                     1)]
         [formed 0]
         [window (make-hash)]
         [ans '(0 . 0)]
         [min-length +inf.0]
         [left 0]
         [right 0])
    (for ([right-char (in-string s)] [right (in-naturals)])
    (for ([right-char (in-string s)] [right (in-naturals)])
      (when (hash-has-key? target right-char)
        (hash-update! window right-char add1 0)
        (when (= (hash-ref window right-char) (hash-ref target right-char))
          (set! formed (add1 formed))))
      (while (and (<= left right) (= formed required))
        (let ([left-char (string-ref s left)])
          (when (< (- right left) min-length)
            (set! min-length (- right left))
            (set! ans (cons left right)))
          (when (hash-has-key? target left-char)
            (hash-update! window left-char sub1)
            (when (< (hash-ref window left-char) (hash-ref target left-char))
              (set! formed (sub1 formed))))
        (set! left (add1 left))))
    (if (= min-length +inf.0)
        ""
        (substring s (car ans) (add1 (cdr ans))))))