(define (cut-bamboos-i heights)
  (if (empty? heights)
      0
      (let* ([min-h (apply min heights)]
             [total-cost (foldl (lambda (h acc)
                                  (+ acc (- h min-h)))
                                0
                                heights)])
        total-cost)))