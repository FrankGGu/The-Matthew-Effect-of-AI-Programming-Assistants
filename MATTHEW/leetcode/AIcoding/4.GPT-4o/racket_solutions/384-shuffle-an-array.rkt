(define (Solution nums)
  (define (shuffle)
    (define n (length nums))
    (define indices (shuffle-helper (range n)))
    (map (lambda (i) (list-ref nums i)) indices))

  (define (shuffle-helper lst)
    (if (null? lst)
        '()
        (let* ((rand-index (random (length lst)))
               (chosen (list-ref lst rand-index))
               (remaining (remove chosen lst)))
          (cons chosen (shuffle-helper remaining)))))

  (define (reset)
    nums)

  (define (reset-or-shuffle reset?)
    (if reset?
        (reset)
        (shuffle)))

  (define (reset-or-shuffle-reset)
    (reset-or-shuffle #t))

  (define (reset-or-shuffle-shuffle)
    (reset-or-shuffle #f))

  (values reset-or-shuffle-reset reset-or-shuffle-shuffle))