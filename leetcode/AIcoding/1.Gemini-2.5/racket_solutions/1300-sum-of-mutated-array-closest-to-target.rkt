#lang racket

(define (calculate-sum arr val)
  (apply + (map (lambda (x) (min x val)) arr)))

(define (find-best-value arr target)
  (let* ((max-arr (apply max arr))
         (low 0)
         (high max-arr))

    (let find-min-value-ge-target ((l low) (h high) (best-ans high))
      (if (> l h)
          (let* ((ans best-ans)
                 (s-ans (calculate-sum arr ans))
                 (diff-ans (abs (- s-ans target))))

            (if (> ans 0)
                (let* ((s-ans-minus-1 (calculate-sum arr (- ans 1)))
                       (diff-ans-minus-1 (abs (- s-ans-minus-1 target))))
                  (if (<= diff-ans-minus-1 diff-ans)
                      (- ans 1)
                      ans))
                ans))

          (let* ((mid (+ l (quotient (- h l) 2)))
                 (current-sum (calculate-sum arr mid)))
            (if (>= current-sum target)
                (find-min-value-ge-target l (- mid 1) mid)
                (find-min-value-ge-target (+ mid 1) h best-ans)))))))