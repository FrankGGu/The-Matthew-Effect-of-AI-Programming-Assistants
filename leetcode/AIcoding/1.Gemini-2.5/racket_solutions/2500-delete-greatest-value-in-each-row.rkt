(define (delete-greatest-value grid)
  (if (empty? grid)
      0
      (let* ((num-rows (length grid))
             (num-cols (length (car grid)))
             (sorted-grid (map (lambda (row) (sort row <)) grid)))
        (for/sum ([col-idx (in-range num-cols)])
          (let* ((current-step-values
                   (map (lambda (row) (list-ref row (- num-cols 1 col-idx)))
                        sorted-grid)))
            (apply max current-step-values))))))