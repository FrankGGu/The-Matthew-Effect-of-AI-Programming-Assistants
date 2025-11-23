(define (reverse-between head left right)
  (define (reverse-list head n)
    (define (helper head n prev)
      (cond
        [(or (null? head) (= n 0)) (values prev head)]
        [else (let* ([next (cdr head)]
                     [head (set-cdr! head prev)])
                (helper next (- n 1) head))]))
    (helper head n null))

  (cond
    [(null? head) head]
    [(= left right) head]
    [else (let loop ([curr head] [count 1] [prev null])
            (cond
              [(= count left)
               (let-values ([(reversed-head tail)] (reverse-list curr (- right left -1)))
                 (if (null? prev)
                     (begin
                       (set-cdr! curr (cdr tail))
                       (set-cdr! tail reversed-head)
                       curr)
                     (begin
                       (set-cdr! prev reversed-head)
                       (set-cdr! curr (cdr tail))
                       (set-cdr! tail reversed-head)
                       head)))]
              [else (loop (cdr curr) (+ count 1) curr)]))]))