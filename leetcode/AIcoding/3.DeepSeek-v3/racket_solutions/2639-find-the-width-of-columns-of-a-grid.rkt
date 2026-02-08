(define (max-col-width grid)
  (if (null? grid)
      '()
      (let* ((num-cols (length (car grid)))
        (for/list ([col (in-range num-cols)])
          (apply max
                 (for/list ([row (in-list grid)])
                   (string-length (number->string (list-ref row col))))))))