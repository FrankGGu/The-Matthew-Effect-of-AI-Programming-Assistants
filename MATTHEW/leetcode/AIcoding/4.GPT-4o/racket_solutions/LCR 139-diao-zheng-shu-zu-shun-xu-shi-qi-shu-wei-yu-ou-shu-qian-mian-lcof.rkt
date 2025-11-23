(define (canCompletePlan calories)
  (define (helper idx k)
    (if (= k 0) #t
        (if (or (= idx (length calories)) (< k 0)) #f
            (or (helper (+ idx 1) k)
                (helper (+ idx 1) (- k (list-ref calories idx)))))))
  (helper 0 0))

(define (trainingPlan cal)
  (for ([i (in-range 1 (add1 (length cal)))])
    (if (not (canCompletePlan (take cal i))) (return #f)))
  #t)