(define (minimum-levels possible-points)
  (let* ((n (length possible-points))
         (scores (map (lambda (p) (if (= p 1) 1 -1)) possible-points))
         (total-score (foldl + 0 scores)))

    (let loop ((k 1)
               (bob-current-sum 0)
               (remaining-scores scores))
      (let* ((current-level-score (car remaining-scores))
             (new-bob-sum (+ bob-current-sum current-level-score)))
        (if (> (* 2 new-bob-sum) total-score)
            k
            (loop (+ k 1) new-bob-sum (cdr remaining-scores)))))))