(define (countUnhappyFriends n preferences pairs)
  (define pair-map (for/list ([i (in-range (length pairs))])
                     (let ([x (car (list-ref pairs i))]
                           [y (cadr (list-ref pairs i))])
                       (cons x y))))

  (define pref-map (for/list ([i (in-range n)])
                     (list-ref preferences i)))

  (define (unhappy? friend)
    (let ([friend-pair (cdr (assoc friend pair-map))])
      (for/or ([other (in-range n)])
        (and (not (= friend other))
             (member friend (list-ref pref-map other))
             (> (index-of (list-ref pref-map other) friend)
                (index-of (list-ref pref-map other) friend-pair))))))

  (define (index-of lst item)
    (for/fold ([idx 0]) ([x lst])
      (if (equal? x item)
          (values idx)
          (set! idx (+ idx 1)))))

  (for/sum ([i (in-range n)] (if (unhappy? i) 1 0)))
)