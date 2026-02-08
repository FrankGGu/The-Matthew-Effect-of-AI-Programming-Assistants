(define (merge-intervals intervals)
  (define sorted-intervals (sort intervals (lambda (a b) (< (car a) (car b)))))

  (define (merge-helper sorted-list acc)
    (cond
      [(empty? sorted-list) (reverse acc)]
      [else
       (define current-interval (car sorted-list))
       (define current-start (car current-interval))
       (define current-end (cadr current-interval))

       (if (empty? acc)
           (merge-helper (cdr sorted-list) (list current-interval))
           (let* ([last-merged-interval (car acc)]
                  [last-merged-start (car last-merged-interval)]
                  [last-merged-end (cadr last-merged-interval)])
             (if (> current-start last-merged-end)
                 (merge-helper (cdr sorted-list) (cons current-interval acc))
                 (let ([new-merged-end (max last-merged-end current-end)])
                   (merge-helper (cdr sorted-list) (cons (list last-merged-start new-merged-end) (cdr acc)))))))]))

  (merge-helper sorted-intervals '()))