(define (head data-frame)
  (if (null? data-frame)
      '()
      (take data-frame (min 3 (length data-frame))))