(define/contract (max-length-between-equal-chars s)
  (-> string? exact-integer?)
  (let ([char-indices (make-hash)])
    (for ([i (in-range (string-length s))]
          [c (in-string s)])
      (hash-update! char-indices c (lambda (lst) (cons i lst)) (list)))
    (let ([max-len -1])
      (hash-for-each char-indices
                     (lambda (c lst)
                       (when (> (length lst) 1)
                         (let ([current-len (- (first lst) (last lst) -1]))
                           (when (> current-len max-len)
                             (set! max-len current-len))))))
      max-len)))