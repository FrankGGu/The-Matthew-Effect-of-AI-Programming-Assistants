(define (shift-grid grid k)
  (let* ((rows (length grid))
         (cols (if (null? grid) 0 (length (car grid))))
         (total-elements (* rows cols)))
    (if (zero? total-elements)
        '()
        (let* ((flat-grid (apply append grid))
               (effective-k (modulo k total-elements))
               (shifted-flat-grid
                (append (take-right flat-grid effective-k)
                        (drop-right flat-grid effective-k))))
          (build-list rows
                      (lambda (i)
                        (take (drop shifted-flat-grid (* i cols)) cols)))))))