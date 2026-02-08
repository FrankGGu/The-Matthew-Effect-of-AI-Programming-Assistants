(define (falling-squares positions)
  (define (update-tree tree start end height)
    (avl-fold (lambda (interval h acc)
                (cond
                  [(<= (avl-key interval) start)
                   (avl-fold (lambda (interval2 h2 acc2)
                               (cond
                                 [(<= (avl-key interval2) end)
                                  (avl-remove tree interval2)]
                                 [else acc2]))
                             tree
                             tree)]
                  [else acc]))
              tree
              tree)
    (avl-insert tree (cons start end) height))

  (define (query-tree tree start end)
    (let loop ([tree tree] [max-height 0])
      (cond
        [(avl-empty? tree) max-height]
        [else
         (let* ([interval (avl-key (avl-root tree))]
                [height (avl-val (avl-root tree))]
                [interval-start (car interval)]
                [interval-end (cdr interval)])
           (cond
             [(or (> interval-start end) (< interval-end start))
              (cond
                [(> interval-start end) (loop (avl-left tree) max-height)]
                [else (loop (avl-right tree) max-height)])]
             [else
              (loop (avl-remove tree interval) (max max-height height))])])]))

  (define (solve positions)
    (let loop ([positions positions] [tree (avl-create <)] [heights '()] [current-height 0])
      (cond
        [(null? positions) (reverse heights)]
        [else
         (let* ([position (car positions)]
                [start (car position)]
                [side (cadr position)]
                [end (+ start side)]
                [max-height (query-tree tree start end)]
                [new-height (+ max-height side)])
           (loop (cdr positions)
                 (update-tree tree start end new-height)
                 (cons (+ current-height side max-height) heights)
                 (+ current-height side max-height)))])))

  (solve positions))