(define (maximum-sum-bst binary-tree)
  (define (helper node)
    (cond
      [(null? node) (values #t 0 +inf.0 -inf.0)]
      [else
       (define-values (left-is-bst left-sum left-min left-max) (helper (car node)))
       (define-values (right-is-bst right-sum right-min right-max) (helper (cdr node)))
       (if (and left-is-bst right-is-bst (if (null? (car node)) #t (> (cadr node) left-max)) (if (null? (cdr node)) #t (< (cadr node) right-min)))
           (let* ((current-sum (+ (cadr node) left-sum right-sum))
                  (current-min (if (null? (car node)) (cadr node) left-min))
                  (current-max (if (null? (cdr node)) (cadr node) right-max)))
             (values #t current-sum current-min current-max))
           (values #f 0 0 0))]))

  (define max-sum 0)
  (define (traverse node)
    (cond
      [(null? node) #t]
      [else
       (define-values (is-bst sum min max) (helper node))
       (when is-bst (set! max-sum (max max-sum sum)))
       (traverse (car node))
       (traverse (cdr node))
       #t]))

  (traverse binary-tree)
  max-sum)