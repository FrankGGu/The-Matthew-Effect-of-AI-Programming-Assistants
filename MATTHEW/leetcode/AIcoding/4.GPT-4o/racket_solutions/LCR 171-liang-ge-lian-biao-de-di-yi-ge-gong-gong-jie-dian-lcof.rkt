(define (can-complete-training-plan target totalTime time)
  (define (dp n t)
    (if (or (= n 0) (= t 0)) 0
        (if (< (vector-ref time (- n 1)) t)
            (dp (- n 1) t)
            (max (dp (- n 1) t)
                 (+ (vector-ref time (- n 1)) (dp (- n 1) (- t (vector-ref time (- n 1)))))))))
  (>= (dp (vector-length time) totalTime) target))

(define (training-plan-v time target totalTime)
  (if (can-complete-training-plan target totalTime time)
      #t
      #f))