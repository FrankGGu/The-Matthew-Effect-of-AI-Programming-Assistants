(define (bstToGst root)
  (let ((sum 0))
    (define (helper node)
      (if (null? node)
          void
          (begin
            (helper (cdr node))
            (set! sum (+ sum (car node)))
            (set-car! node sum)
            (helper (car node)))))
    (helper root)
    root))