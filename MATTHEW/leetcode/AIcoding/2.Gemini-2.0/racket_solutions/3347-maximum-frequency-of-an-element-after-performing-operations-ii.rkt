(define (max-frequency nums k)
  (define (solve nums k)
    (define (max-freq nums k left right current-freq)
      (if (>= right (length nums))
          current-freq
          (let* ((window-size (+ right 1))
                 (cost (* (list-ref nums right) window-size) - (apply + (take nums window-size))))
            (if (<= cost k)
                (max-freq nums k left (+ right 1) (max current-freq (+ right 1 - left)))
                (max-freq nums k (+ left 1) right current-freq)))))

    (let ((sorted-nums (sort nums <)))
      (max-freq sorted-nums k 0 0 0)))

  (solve nums k))