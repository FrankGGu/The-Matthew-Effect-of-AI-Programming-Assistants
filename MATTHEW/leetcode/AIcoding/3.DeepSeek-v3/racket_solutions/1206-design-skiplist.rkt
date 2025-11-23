(define-struct skipnode (val next down) #:mutable #:transparent)

(define (make-skipnode val [next #f] [down #f])
  (skipnode val next down))

(define skiplist%
  (class object%
    (super-new)
    (init-field)
    (field [head (make-skipnode -1 #f #f)]
           [levels 0])

    (define/public (search target)
      (let loop ([node head])
        (cond
          [(not node) #f]
          [(and (skipnode-next node)
                (< (skipnode-val (skipnode-next node)) target))
           (loop (skipnode-next node))]
          [(or (not (skipnode-next node))
               (> (skipnode-val (skipnode-next node)) target))
           (if (skipnode-down node)
               (loop (skipnode-down node))
               #f)]
          [else #t])))

    (define/public (add num)
      (let ([stack '()]
            [node head])
        (let loop ([node node])
          (cond
            [(and (skipnode-next node)
                  (< (skipnode-val (skipnode-next node)) num))
             (loop (skipnode-next node))]
            [(skipnode-down node)
             (set! stack (cons node stack))
             (loop (skipnode-down node))]
            [else (set! stack (cons node stack))]))
        (let ([inserted #f]
              [down #f]
              [level 0])
          (let loop ()
            (when (and (not (null? stack))
                       (or (not inserted) (zero? (random 2))))
              (let* ([prev (car stack)]
                     [stack (cdr stack)]
                     [new-node (make-skipnode num (skipnode-next prev) down)])
                (set-skipnode-next! prev new-node)
                (set! down new-node)
                (set! inserted #t)
                (set! level (add1 level))
                (when (> level levels)
                  (let ([new-head (make-skipnode -1 #f head)])
                    (set! head new-head)
                    (set! levels (add1 levels))
                    (set! stack (cons new-head stack))))
                (loop))))
          inserted))

    (define/public (erase num)
      (let ([found #f]
            [node head])
        (let loop ([node node])
          (cond
            [(not node) found]
            [(and (skipnode-next node)
                  (< (skipnode-val (skipnode-next node)) num))
             (loop (skipnode-next node))]
            [(or (not (skipnode-next node))
                 (> (skipnode-val (skipnode-next node)) num))
             (loop (skipnode-down node))]
            [else
             (set! found #t)
             (set-skipnode-next! node (skipnode-next (skipnode-next node)))
             (loop (skipnode-down node))]))))))

(define (make-skiplist) (new skiplist%))