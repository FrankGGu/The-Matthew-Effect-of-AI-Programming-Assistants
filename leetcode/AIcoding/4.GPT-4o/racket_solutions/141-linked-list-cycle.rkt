(define (hasCycle head)
  (define (helper slow fast)
    (if (or (null? fast) (null? (cdr fast)))
        #f
        (if (eq? slow fast)
            #t
            (helper (cdr slow) (cdr (cdr fast))))))
  (helper head head))