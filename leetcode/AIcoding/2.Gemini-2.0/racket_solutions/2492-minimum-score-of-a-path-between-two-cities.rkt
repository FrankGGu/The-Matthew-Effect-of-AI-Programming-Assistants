(define (min-score n roads)
  (define adj (make-hash))
  (for ([road roads])
    (let* ([u (car road)]
           [v (cadr road)]
           [w (caddr road)])
      (hash-update! adj u (lambda (x) (cons (cons v w) x)) '())
      (hash-update! adj v (lambda (x) (cons (cons u w) x)) '())))

  (define visited (make-vector (add1 n) #f))
  (vector-set! visited 1 #t)

  (define (dfs u min-so-far)
    (for ([neighbor (hash-ref adj u '())])
      (let ([v (car neighbor)]
            [w (cdr neighbor)])
        (let ([new-min (min min-so-far w)])
          (if (not (vector-ref visited v))
              (begin
                (vector-set! visited v #t)
                (set! new-min (dfs v new-min)))
              #f)
          )))
    min-so-far)

  (dfs 1 +inf.0))