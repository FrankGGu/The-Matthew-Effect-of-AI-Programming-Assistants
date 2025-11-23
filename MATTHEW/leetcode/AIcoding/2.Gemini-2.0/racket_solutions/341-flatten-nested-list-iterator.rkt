(define (nested-list-iterator nestedList)
  (let* ([flat-list (flatten nestedList)]
         [current-index (box 0)])
    (define (hasNext)
      (< (unbox current-index) (length flat-list)))
    (define (next)
      (if (hasNext)
          (let ([result (list-ref flat-list (unbox current-index))])
            (set-box! current-index (+ (unbox current-index) 1))
            result)
          (error "No more elements")))
    (define (flatten lst)
      (cond
        [(null? lst) '()]
        [(number? lst) (list lst)]
        [(list? lst) (apply append (map flatten lst))]
        [else (error "Invalid input")]))
    (struct iterator (hasNext next) #:transparent)
    (iterator hasNext next)))