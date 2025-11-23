(define (maximize-happiness happiness k)
  (let ([sorted-happiness (sort happiness >)])
    (for/sum ([i (in-range k)]
              [h (in-list sorted-happiness)])
      (max 0 (- h i)))))