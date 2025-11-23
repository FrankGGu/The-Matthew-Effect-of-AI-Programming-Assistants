(define/contract (min-window s t)
  (-> string? string? string?)
  (let* ([s-len (string-length s)]
         [t-len (string-length t)]
         [t-count (make-hash)])
    (when (or (zero? s-len) (zero? t-len) (< s-len t-len))
      (return ""))

    (for ([ch (in-string t)])
      (hash-update! t-count ch (lambda (x) (+ x 1)) 0))

    (let ([required (hash-count t-count)]
          [left 0]
          [right 0]
          [formed 0]
          [window-count (make-hash)]
          [ans '(#f 0 0)])

      (for ([right (in-range s-len)])
        (let ([ch (string-ref s right)])
          (hash-update! window-count ch (lambda (x) (+ x 1)) 0)

          (when (and (hash-has-key? t-count ch)
                     (= (hash-ref window-count ch) (hash-ref t-count ch)))
            (set! formed (+ formed 1)))

          (while (and (<= left right) (= formed required))
            (let ([ch (string-ref s left)])
              (when (not (first ans))
                (set! ans (list #t left right))
              (when (< (- right left) (- (third ans) (second ans)))
                (set! ans (list #t left right)))

              (hash-update! window-count ch (lambda (x) (- x 1)) 1)
              (when (and (hash-has-key? t-count ch)
                         (< (hash-ref window-count ch) (hash-ref t-count ch)))
                (set! formed (- formed 1)))
              (set! left (+ left 1)))))

      (if (first ans)
          (substring s (second ans) (+ (third ans) 1))
          "")))