(define (get-equal-substrings-within-budget s t maxCost)
  (let* ([n (string-length s)]
         [costs (for/vector ([i (in-range n)])
                  (abs (- (char->integer (string-ref s i))
                          (char->integer (string-ref t i)))))]
         [left 0]
         [current-cost 0]
         [max-len 0])
    (for ([right (in-range n)])
      (set! current-cost (+ current-cost (vector-ref costs right)))
      (while (> current-cost maxCost)
        (set! current-cost (- current-cost (vector-ref costs left)))
        (set! left (+ left 1)))
      (set! max-len (max max-len (- right left -1))))
    max-len))