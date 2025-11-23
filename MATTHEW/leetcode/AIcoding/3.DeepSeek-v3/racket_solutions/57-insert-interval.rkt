(define/contract (insert intervals newInterval)
  (-> (listof (listof exact-integer?)) (listof exact-integer?) (listof (listof exact-integer?)))
  (define (insert-interval intervals new-interval)
    (let loop ([left '()]
               [right intervals]
               [new new-interval])
      (cond
        [(null? right) (append left (list new))]
        [(< (cadr new) (caar right)) (append left (cons new right))]
        [(> (car new) (cadar right)) (loop (append left (list (car right))) (cdr right) new)]
        [else (loop left (cdr right) (list (min (car new) (caar right)) (max (cadr new) (cadar right)))])))
  (insert-interval intervals newInterval))