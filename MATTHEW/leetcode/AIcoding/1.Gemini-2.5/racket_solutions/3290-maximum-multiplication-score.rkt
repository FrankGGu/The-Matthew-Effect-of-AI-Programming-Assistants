(define (maximum-multiplication-score nums multipliers)
  (let* ((n (length nums))
         (m (length multipliers))
         (memo (make-vector (add1 m) #f)))

    (for ((i (in-range (add1 m))))
      (vector-set! memo i (make-vector (add1 m) #f)))

    (letrec ((solve (lambda (left-taken mult-idx)
                      (cond
                        ((= mult-idx m) 0)

                        ((vector-ref (vector-ref memo left-taken) mult-idx)
                         => (lambda (val) val))

                        (else
                         (let* ((right-taken (- mult-idx left-taken))
                                (current-multiplier (list-ref multipliers mult-idx))

                                (left-num (list-ref nums left-taken))
                                (score-left (+ (* left-num current-multiplier)
                                               (solve (add1 left-taken) (add1 mult-idx))))

                                (right-num-idx (- n 1 right-taken))
                                (right-num (list-ref nums right-num-idx))
                                (score-right (+ (* right-num current-multiplier)
                                                (solve left-taken (add1 mult-idx))))

                                (max-score (max score-left score-right)))

                           (vector-set! (vector-ref memo left-taken) mult-idx max-score)
                           max-score))))))

      (solve 0 0))))