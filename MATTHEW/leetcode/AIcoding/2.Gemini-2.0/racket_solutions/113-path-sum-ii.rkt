(define (path-sum root target-sum)
  (define (path-sum-helper node current-sum current-path)
    (cond
      [(null? node) '()]
      [else
       (let* ([new-sum (+ current-sum (car node))]
              [new-path (append current-path (list (car node)))])
         (cond
           [(and (null? (cadr node)) (null? (caddr node)) (= new-sum target-sum)) (list new-path)]
           [else
            (append (path-sum-helper (cadr node) new-sum new-path)
                    (path-sum-helper (caddr node) new-sum new-path))]))]))
  (path-sum-helper root 0 '()))