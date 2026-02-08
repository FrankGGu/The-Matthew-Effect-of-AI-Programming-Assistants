(define (cut-bamboo height)
  (cond
    [(<= height 1) 0]
    [else (+ 1 (cut-bamboo (ceiling (/ height 2))))]))