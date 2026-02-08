(define/contract (remove-nth-from-end head n)
  (-> (or/c list? null?) exact-positive-integer? (or/c list? null?))
  (let* ([dummy (cons 0 head)]
         [fast dummy]
         [slow dummy])
    (for ([i (in-range n)])
      (set! fast (cdr fast)))
    (let loop ()
      (when (not (null? (cdr fast)))
        (set! fast (cdr fast))
        (set! slow (cdr slow))
        (loop)))
    (set-cdr! slow (cdr (cdr slow)))
    (cdr dummy)))