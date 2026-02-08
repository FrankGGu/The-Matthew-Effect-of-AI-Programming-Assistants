(define (odd-even-list head)
  (cond
    [(or (null? head) (null? (cdr head))) head]
    [else
     (let loop ([odd head] [even (cdr head)] [even-head (cdr head)])
       (cond
         [(or (null? even) (null? (cdr even)))
          (set-cdr! odd even-head)
          (set-cdr! even null)
          head]
         [else
          (let ([next-odd (cdr even)]
                [next-even (cdr next-odd)])
            (set-cdr! even next-even)
            (set-cdr! odd next-odd)
            (loop next-odd next-even even-head))]))]))