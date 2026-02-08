(define smallest-infinite-set%
  (class object%
    (super-new)
    (init-field)
    (field [current 1]
           [added (make-hash)]
           [removed (make-hash)])

    (define/public (popSmallest)
      (let ([min-added (hash-iterate-key added (lambda (k v) k))])
        (cond
          [(and min-added (< min-added current))
           (hash-remove! added min-added)
           min-added]
          [else
           (let ([result current])
             (hash-set! removed current #t)
             (set! current (add1 current))
             result)])))

    (define/public (addBack num)
      (when (hash-has-key? removed num)
        (hash-remove! removed num)
        (hash-set! added num #t)))))

(define (make-smallest-infinite-set)
  (new smallest-infinite-set%))