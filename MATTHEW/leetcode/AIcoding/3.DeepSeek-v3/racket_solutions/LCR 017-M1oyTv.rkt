(define/contract (min-window s t)
  (-> string? string? string?)
  (let* ([s-len (string-length s)]
         [t-len (string-length t)]
         [t-count (make-hash)]
         [window-count (make-hash)]
         [required 0]
         [formed 0]
         [ans (list +inf.0 0 0)]
         [left 0]
         [right 0])
    (for ([c (in-string t)])
      (hash-update! t-count c add1 0))
    (set! required (hash-count t-count))
    (while (< right s-len)
      (let ([c (string-ref s right)])
      (hash-update! window-count c add1 0)
      (when (and (hash-has-key? t-count c)
                 (= (hash-ref window-count c) (hash-ref t-count c)))
        (set! formed (add1 formed)))
      (while (and (<= formed required) (<= left right))
        (let ([c (string-ref s left)])
          (when (< (- right left) (car ans))
            (set! ans (list (- right left) left right)))
          (hash-update! window-count c sub1 0)
          (when (and (hash-has-key? t-count c)
                     (< (hash-ref window-count c) (hash-ref t-count c)))
            (set! formed (sub1 formed)))
          (set! left (add1 left))))
      (set! right (add1 right)))
    (if (= (car ans) +inf.0)
        ""
        (substring s (cadr ans) (add1 (caddr ans))))))