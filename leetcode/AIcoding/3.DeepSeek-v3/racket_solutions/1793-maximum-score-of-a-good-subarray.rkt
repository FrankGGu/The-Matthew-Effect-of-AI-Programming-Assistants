(define (maximum-score nums k)
  (let loop ([left k] [right k] [min-val (list-ref nums k)] [max-score (list-ref nums k)])
    (cond
      [(and (= left 0) (= right (- (length nums) 1))) max-score]
      [(or (= left 0) (and (< right (- (length nums) 1)) 
                           (> (list-ref nums (- right 1)) (list-ref nums (+ left 1)))))
       (let ([new-right (+ right 1)])
         (loop left new-right (min min-val (list-ref nums new-right)) 
               (max max-score (* min-val (- new-right left +1)))))]
      [else
       (let ([new-left (- left 1)])
         (loop new-left right (min min-val (list-ref nums new-left)) 
               (max max-score (* min-val (- right new-left +1)))))])))