(define (maximum-bob-points alice-arrows)
  (define n (length alice-arrows))
  (define max-points 0)
  (define best-bob-arrows '())

  (define (dfs index remaining-arrows current-points current-bob-arrows)
    (if (or (= index n) (zero? remaining-arrows))
        (begin
          (when (> current-points max-points)
            (set! max-points current-points)
            (set! best-bob-arrows (append current-bob-arrows (make-list (- n index) 0))))
          (void))
        (begin
          (dfs (add1 index) remaining-arrows current-points (append current-bob-arrows (list 0)))
          (when (> remaining-arrows (list-ref alice-arrows index))
            (dfs (add1 index)
                 (- remaining-arrows (add1 (list-ref alice-arrows index)))
                 (+ current-points index)
                 (append current-bob-arrows (list (add1 (list-ref alice-arrows index)))))))))

  (dfs 0 12 0 '())
  (if (null? best-bob-arrows)
      (make-list n 0)
      best-bob-arrows))