(define number-container%
  (class object%
    (super-new)
    (init-field)
    (define index-map (make-hash))
    (define number-map (make-hash))

    (define/public (change index number)
      (when (hash-has-key? index-map index)
        (let ([prev-number (hash-ref index-map index)])
          (hash-update! number-map prev-number (lambda (s) (set-remove s index)))))
      (hash-set! index-map index number)
      (hash-update! number-map number (lambda (s) (set-add (if (hash-has-key? number-map number) s (set)) index)))

    (define/public (find number)
      (if (hash-has-key? number-map number)
          (let ([s (hash-ref number-map number)])
            (if (set-empty? s) -1 (set-first s)))
          -1)))