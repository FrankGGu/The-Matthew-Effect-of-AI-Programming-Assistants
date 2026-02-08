(define (merge intervals)
  (define (cmp a b)
    (- (car a) (car b)))

  (define (merge-intervals sorted-intervals)
    (if (null? sorted-intervals)
        '()
        (let loop ([result (list (car sorted-intervals))]
                   [remaining-intervals (cdr sorted-intervals)])
          (if (null? remaining-intervals)
              result
              (let ([last-merged (car result)]
                    [current-interval (car remaining-intervals)])
                (if (<= (cadr last-merged) (car current-interval))
                    (loop (cons current-interval result) (cdr remaining-intervals))
                    (loop (cons (list (car last-merged) (max (cadr last-merged) (cadr current-interval))) (cdr result)) (cdr remaining-intervals))))))))

  (reverse (merge-intervals (sort intervals cmp))))