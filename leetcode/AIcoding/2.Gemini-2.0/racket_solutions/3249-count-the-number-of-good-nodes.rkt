(define (good-nodes root)
  (define (helper node max-val)
    (cond
      [(null? node) 0]
      [else
       (let ([current-val (car node)])
         (+ (if (>= current-val max-val) 1 0)
            (helper (cadr node) (max max-val current-val))
            (helper (caddr node) (max max-val current-val))))]))
  (helper root (-(expt 10 9) 1)))