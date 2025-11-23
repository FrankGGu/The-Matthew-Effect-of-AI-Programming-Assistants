(define/contract (buddy-strings s goal)
  (-> string? string? boolean?)
  (let ((n (string-length s))
        (m (string-length goal)))
    (if (not (= n m))
        #f
        (let ((diff-indices '())
              (same-chars (make-hash)))
          (for ([i (in-range n)])
            (let ((c (string-ref s i))
                  (d (string-ref goal i)))
              (if (not (eqv? c d))
                  (set! diff-indices (cons i diff-indices))
                  (hash-update! same-chars c (lambda (v) (+ v 1)) 1))))
          (cond
            [(= (length diff-indices) 2)
             (let ((i (first diff-indices))
                   (j (second diff-indices)))
               (and (eqv? (string-ref s i) (string-ref goal j))
                    (eqv? (string-ref s j) (string-ref goal i))))]
            [(= (length diff-indices) 0)
             (ormap (lambda (v) (>= v 2)) (hash-values same-chars))]
            [else #f]))))