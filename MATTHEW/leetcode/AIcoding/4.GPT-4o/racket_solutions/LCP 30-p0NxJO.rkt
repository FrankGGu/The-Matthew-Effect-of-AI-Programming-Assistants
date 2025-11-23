(define (magic-tower nums)
  (define (can-survive start)
    (define (loop index health)
      (if (>= index (length nums))
          #t
          (let ((new-health (+ health (list-ref nums index))))
            (if (> new-health 0)
                (loop (+ index 1) new-health)
                #f))))
    (loop start 1))

  (for/fold ((min-start (length nums))) ((i 0) (start (length nums)))
    (if (can-survive i)
        (min min-start i)
        min-start)))

(define (magic-tower-main nums)
  (let ((result (magic-tower nums)))
    (if (= result (length nums))
        -1
        result)))

(magic-tower-main '(1, -2, 1, -2, -2))