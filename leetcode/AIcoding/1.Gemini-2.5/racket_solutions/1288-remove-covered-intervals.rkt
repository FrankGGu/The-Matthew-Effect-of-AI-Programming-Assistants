(define (remove-covered-intervals intervals)
  (define (compare-intervals a b)
    (let ((as (car a))
          (ae (cadr a))
          (bs (car b))
          (be (cadr b)))
      (cond
        ((< as bs) #t)
        ((> as bs) #f)
        ((> ae be) #t)
        (#else #f))))

  (define sorted-intervals (sort intervals compare-intervals))

  (define (process-interval interval acc)
    (let ((current-end (cadr interval)))
      (let ((count (car acc))
            (max-end (cadr acc)))
        (if (> current-end max-end)
            (list (+ count 1) current-end)
            acc))))

  (let ((final-acc (foldl process-interval (list 0 -1) sorted-intervals)))
    (car final-acc)))