(define (separate-balls balls)
  (define (helper balls l r count)
    (cond
      [(>= l r) count]
      [else
       (cond
         [(= (list-ref balls l) 1)
          (helper balls (+ l 1) r count)]
         [(= (list-ref balls r) 0)
          (helper balls l (- r 1) count)]
         [else
          (helper (list-set balls l 1 (list-set balls r 0 balls)) (+ l 1) (- r 1) (+ count 1))])]))
  (helper balls 0 (- (length balls) 1) 0))