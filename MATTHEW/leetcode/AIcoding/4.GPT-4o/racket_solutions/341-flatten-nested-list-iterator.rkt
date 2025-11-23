(define NestedIterator
  (lambda (nestedList)
    (define (flatten lst)
      (apply append
             (map (lambda (x)
                    (if (list? x)
                        (flatten x)
                        (list x)))
                  lst)))
    (define flatList (flatten nestedList))
    (define index 0)
    (define next
      (lambda ()
        (if (< index (length flatList))
            (let ((value (list-ref flatList index)))
              (set! index (+ index 1))
              value)
            (error "No more elements"))))
    (define hasNext
      (lambda ()
        (< index (length flatList)))
    (list next hasNext)))

(define iterator (NestedIterator '((1,1),2,(1,(4,(6))))))
(display (iterator-ref (car iterator))) ; next
(display (iterator-ref (cdr iterator))) ; hasNext