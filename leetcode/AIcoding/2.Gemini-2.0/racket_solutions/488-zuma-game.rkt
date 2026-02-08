(define (find-min-steps board hand)
  (define (remove-consecutive board)
    (let loop ([board board] [res '()])
      (cond
        [(empty? board) (reverse res)]
        [(<= (length board) 2) (reverse (append res board))]
        [else
         (let ([first (car board)]
               [count 1])
           (let loop2 ([rest (cdr board)])
             (cond
               [(empty? rest)
                (if (>= count 3)
                    (reverse res)
                    (reverse (append res (make-list count first))))]
               [(equal? first (car rest))
                (loop2 (cdr rest) (+ count 1))]
               [else
                (if (>= count 3)
                    (loop (cdr rest) res)
                    (loop (cdr rest) (append res (make-list count first))))]))))]))))

  (define (solve board hand)
    (cond
      [(empty? board) 0]
      [(empty? hand) -1]
      [else
       (let ([min-steps #f])
         (for/list ([i (in-range (add1 (length board)))])
           (for/list ([color (remove-duplicates hand)])
             (let* ([new-board (append (take board i) (list color) (drop board i))]
                    [reduced-board (remove-consecutive new-board)]
                    [new-hand (remove color hand 1)])
               (let ([sub-steps (solve reduced-board new-hand)])
                 (when (and (not (equal? sub-steps -1)))
                   (set! min-steps (min (if min-steps min-steps +inf.0) (+ 1 sub-steps)))))))))
         (if min-steps min-steps -1))]))

  (solve (string->list board) (string->list hand)))