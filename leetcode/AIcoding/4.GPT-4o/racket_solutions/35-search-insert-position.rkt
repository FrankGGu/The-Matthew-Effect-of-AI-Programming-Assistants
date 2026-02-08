(define (search-insert nums target)
  (define (binary-search left right)
    (if (>= left right)
        left
        (let* ((mid (quotient (+ left right) 2))
               (mid-val (list-ref nums mid)))
          (cond
            ((< mid-val target) (binary-search (+ mid 1) right))
            (else (binary-search left mid))))))
  (binary-search 0 (length nums)))