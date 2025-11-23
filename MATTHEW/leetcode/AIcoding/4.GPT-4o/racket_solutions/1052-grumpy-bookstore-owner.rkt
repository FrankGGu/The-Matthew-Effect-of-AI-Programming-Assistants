(define (maxSatisfied customers grumpy minutes)
  (define (calculate-satisfaction customers grumpy)
    (foldl (lambda (c acc)
              (+ acc (if (= c 1) 1 0)))
            0
            customers))

  (define total-satisfied (calculate-satisfaction customers grumpy))

  (define (max-additional-satisfaction customers grumpy minutes)
    (define (helper i j count)
      (if (>= i (length customers))
          count
          (let ((new-count (if (and (< i j) (= (list-ref grumpy i) 1)) 1 0)))
            (max (helper (+ i 1) j (+ count new-count))
                 (if (< j minutes) 
                     (helper i (+ j 1) count)
                     (if (= (list-ref grumpy i) 1) 
                         (helper (+ i 1) j count) 
                         (helper (+ i 1) (+ j 1) count)))))))
    (helper 0 0 0))

  (+ total-satisfied (max-additional-satisfaction customers grumpy minutes)))