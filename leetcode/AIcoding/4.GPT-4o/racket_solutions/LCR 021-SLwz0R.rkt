(define (removeNthFromEnd head n)
  (define (length node)
    (if (null? node)
        0
        (+ 1 (length (cdr node)))))

  (define len (length head))
  (define target (- len n))

  (define (helper node idx)
    (cond
      [(null? node) (values #f)]
      [(= idx target) (values (cdr node) #t)]
      [else (define-values (next found) (helper (cdr node) (+ idx 1)))
            (if found
                (values (cons (car node) next) found)
                (values (cons (car node) (cdr node)) found)))]))

  (define-values (new-head _) (helper head 0))
  (if (= len n)
      (cdr head)
      new-head))