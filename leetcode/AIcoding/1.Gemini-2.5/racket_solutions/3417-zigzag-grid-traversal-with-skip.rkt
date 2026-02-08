(define (zigzag-grid-traversal-with-skip grid skip-interval skip-count)
  (let* ([R (length grid)]
         [C (if (null? grid) 0 (length (car grid)))])

    (if (or (= R 0) (= C 0)) '()
        (let* ([flat-zigzag-list
                (apply append
                       (for/list ([row (in-list grid)]
                                  [row-idx (in-naturals)])
                         (if (even? row-idx)
                             row
                             (reverse row))))])

          (if (or (<= skip-interval 0) (null? flat-zigzag-list))
              '()
              (let loop-skip ([remaining-elements flat-zigzag-list]
                              [collected-so-far '()]
                              [collect-counter 0]
                              [skip-counter 0])

                (cond
                  [(null? remaining-elements) (reverse collected-so-far)]

                  ; State: Collecting
                  [(< collect-counter skip-interval)
                   (loop-skip (cdr remaining-elements)
                              (cons (car remaining-elements) collected-so-far)
                              (+ collect-counter 1)
                              0)]

                  ; State: Skipping
                  [(< skip-counter skip-count)
                   (loop-skip (cdr remaining-elements)
                              collected-so-far
                              0
                              (+ skip-counter 1))]

                  ; State: Finished skipping, transition back to collecting
                  [else
                   (loop-skip (cdr remaining-elements)
                              (cons (car remaining-elements) collected-so-far)
                              1
                              0)]))))))