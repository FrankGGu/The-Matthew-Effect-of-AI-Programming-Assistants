(define (reorder-list head)
  (cond
    [(or (null? head) (null? (cdr head))) head]
    [else
     (let* ([slow head]
            [fast head])
       (let loop ()
         (cond
           [(or (null? fast) (null? (cdr fast))) (void)]
           [else (set! slow (cdr slow))
                 (set! fast (cddr fast))
                 (loop)]))
       (let* ([head1 head]
              [head2 (cdr slow)])
         (set-cdr! slow null)
         (letrec ([reverse (lambda (head prev)
                             (cond
                               [(null? head) prev]
                               [else (let ([next (cdr head)])
                                       (set-cdr! head prev)
                                       (reverse next head))]))]
                  [merge (lambda (h1 h2)
                           (cond
                             [(null? h1) h2]
                             [(null? h2) h1]
                             [else (let ([next1 (cdr h1)]
                                         [next2 (cdr h2)])
                                     (set-cdr! h1 h2)
                                     (set-cdr! h2 (merge next1 next2))
                                     h1)]))])
           (merge head1 (reverse head2 null))))]))