(define (minimum-operations nums)
  (let* ([n (length nums)]
         [even-counts (make-hash)]
         [odd-counts (make-hash)]
         [max-even (cons 0 0)]
         [second-even (cons 0 0)]
         [max-odd (cons 0 0)]
         [second-odd (cons 0 0)])
    (for ([i (in-range n)]
          [num nums])
      (if (even? i)
          (hash-update! even-counts num add1 0)
          (hash-update! odd-counts num add1 0)))
    (for ([(k v) (in-hash even-counts)])
      (cond [(> v (cdr max-even))
             (set! second-even max-even)
             (set! max-even (cons k v))]
            [(> v (cdr second-even))
             (set! second-even (cons k v))]))
    (for ([(k v) (in-hash odd-counts)])
      (cond [(> v (cdr max-odd))
             (set! second-odd max-odd)
             (set! max-odd (cons k v))]
            [(> v (cdr second-odd))
             (set! second-odd (cons k v))]))
    (if (not (equal? (car max-even) (car max-odd)))
        (- n (+ (cdr max-even) (cdr max-odd)))
        (min (- n (+ (cdr max-even) (cdr second-odd)))
             (- n (+ (cdr second-even) (cdr max-odd)))))))