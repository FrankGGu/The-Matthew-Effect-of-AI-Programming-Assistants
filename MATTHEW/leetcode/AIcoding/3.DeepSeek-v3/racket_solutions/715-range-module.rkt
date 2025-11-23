(define range-module%
  (class object%
    (super-new)

    (define ranges '())

    (define/public (add-range left right)
      (let loop ([rs ranges]
                 [new-ranges '()])
        (cond
          [(null? rs) (set! ranges (reverse (cons (cons left right) new-ranges)))]
          [(> (caar rs) right) 
           (set! ranges (append (reverse (cons (cons left right) new-ranges)) rs))]
          [(< (cdar rs) left) 
           (loop (cdr rs) (cons (car rs) new-ranges))]
          [else 
           (let ([new-left (min left (caar rs))]
                 [new-right (max right (cdar rs))])
             (loop (cdr rs) (cons (cons new-left new-right) new-ranges)]))))

    (define/public (query-range left right)
      (let loop ([rs ranges])
        (cond
          [(null? rs) #f]
          [(<= (caar rs) left) (>= (cdar rs) right)]
          [else (loop (cdr rs))])))

    (define/public (remove-range left right)
      (let loop ([rs ranges]
                 [new-ranges '()])
        (cond
          [(null? rs) (set! ranges (reverse new-ranges))]
          [(> (caar rs) right) 
           (set! ranges (append (reverse new-ranges) rs))]
          [(< (cdar rs) left) 
           (loop (cdr rs) (cons (car rs) new-ranges))]
          [else
           (let ([current-left (caar rs)]
                 [current-right (cdar rs))])
             (when (< current-left left)
               (set! new-ranges (cons (cons current-left left) new-ranges)))
             (when (> current-right right)
               (set! new-ranges (cons (cons right current-right) new-ranges)))
             (loop (cdr rs) new-ranges)])))))