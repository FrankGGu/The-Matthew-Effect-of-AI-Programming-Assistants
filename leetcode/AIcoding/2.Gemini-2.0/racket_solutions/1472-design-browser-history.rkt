(define browser-history%
  (class object%
    (init-field! history '())
    (init-field! current-index 0)

    (define/public (visit url)
      (set! history (append (take history current-index) (list url)))
      (set! current-index (+ current-index 1))
      (void))

    (define/public (back steps)
      (let ([new-index (max 1 (- current-index steps))])
        (set! current-index new-index)
        (list-ref history (- current-index 1))))

    (define/public (forward steps)
      (let ([new-index (min (length history) (+ current-index steps))])
        (set! current-index new-index)
        (list-ref history (- current-index 1))))

    (define/public (get-current)
      (list-ref history (- current-index 1)))))

(provide browser-history%)