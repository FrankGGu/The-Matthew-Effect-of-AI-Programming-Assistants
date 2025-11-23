(define (can-reach-end stones)
  (define (helper index prev-jump)
    (cond [(= index (sub1 (length stones))) #t]
          [else
           (for/or ([i (in-range (add1 index) (length stones))])
             (let ([jump (- (list-ref stones i) (list-ref stones index))])
               (and (>= jump 1)
                    (or (= jump prev-jump)
                        (= jump (add1 prev-jump))
                        (= jump (sub1 prev-jump)))
                    (helper i jump)))])])
  (helper 0 0))

(define (frog-jump stones)
  (if (<= (length stones) 1)
      #t
      (helper 0 0)))