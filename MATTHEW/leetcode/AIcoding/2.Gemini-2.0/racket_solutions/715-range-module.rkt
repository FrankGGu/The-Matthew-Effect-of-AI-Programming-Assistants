(define range-module%
  (class object%
    (super-new)

    (define ranges (set))

    (define/public (add-range left right)
      (let loop ([ranges ranges] [new-ranges (set)])
        (cond
          [(set-empty? ranges)
           (set! ranges (set-add new-ranges (cons left right)))]
          [else
           (let* ([r (set-first ranges)]
                  [l (car r)]
                  [rr (cdr r)]
                  [remaining-ranges (set-remove ranges r)])
             (cond
               [(> l right)
                (loop remaining-ranges (set-add new-ranges r))]
               [(< rr left)
                (loop remaining-ranges (set-add new-ranges r))]
               [else
                (let ([new-left (min left l)]
                      [new-right (max right rr)])
                  (loop remaining-ranges new-ranges)
                  (add-range new-left new-right)
                  )])])]))
      (void))

    (define/public (query-range left right)
      (let loop ([ranges ranges])
        (cond
          [(set-empty? ranges)
           #f]
          [else
           (let* ([r (set-first ranges)]
                  [l (car r)]
                  [rr (cdr r)]
                  [remaining-ranges (set-remove ranges r)])
             (cond
               [(> l right)
                (loop remaining-ranges)]
               [(< rr left)
                (loop remaining-ranges)]
               [else
                (and (<= l left) (>= rr right))])])]))

    (define/public (remove-range left right)
      (let loop ([ranges ranges] [new-ranges (set)])
        (cond
          [(set-empty? ranges)
           (set! ranges new-ranges)]
          [else
           (let* ([r (set-first ranges)]
                  [l (car r)]
                  [rr (cdr r)]
                  [remaining-ranges (set-remove ranges r)])
             (cond
               [(> l right)
                (loop remaining-ranges (set-add new-ranges r))]
               [(< rr left)
                (loop remaining-ranges (set-add new-ranges r))]
               [else
                (cond
                  [(and (<= l left) (>= rr right))
                   (loop remaining-ranges new-ranges)]
                  [(< l left)
                   (loop remaining-ranges (set-add new-ranges (cons l left)))]
                  [(> rr right)
                   (loop remaining-ranges (set-add new-ranges (cons right rr)))]
                  [else
                   (loop remaining-ranges (set-add new-ranges (cons l left)))
                   (add-range right rr)]
                  )])])]))
      (void)))

(define (make-range-module) (new range-module%))