(define two-sum%
  (class object%
    (init-field [numbers (make-hash-table)])

    (define/public (add num)
      (hash-table-update! numbers num (lambda (v) (+ v 1)) 0))

    (define/public (find value)
      (let ([found #f])
        (for ([(num count) numbers] #:unless found)
          (let ([complement (- value num)])
            (cond
              [(= num complement)
               (when (>= count 2)
                 (set! found #t))]
              [else
               (when (hash-table-has-key? numbers complement)
                 (set! found #t))])))
        found))))