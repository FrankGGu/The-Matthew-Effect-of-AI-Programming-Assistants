(define (lock tree node)
  (hash-set! tree node #t))

(define (unlock tree node)
  (hash-set! tree node #f))

(define (is-locked tree node)
  (hash-ref tree node #f))

(define (lock-ancestor-descendant tree node)
  (define (has-locked-ancestor node)
    (cond
      [(not (hash-has-key? tree node)) #f]
      [(hash-ref tree node #f) #t]
      [else (let ([parent (hash-ref tree 'parent (hash #f))])
              (if (hash-has-key? parent node)
                  (has-locked-ancestor (hash-ref parent node))
                  #f))]))

  (define (has-locked-descendant node)
    (cond
      [(not (hash-has-key? tree 'children)) #f]
      [(not (hash-has-key? (hash-ref tree 'children (hash #f)) node)) #f]
      [else
       (let loop ([children (hash-ref (hash-ref tree 'children (hash #f)) node)])
         (cond
           [(null? children) #f]
           [(is-locked tree (car children)) #t]
           [else (or (has-locked-descendant (car children))
                     (loop (cdr children)))]))]))

  (and (not (has-locked-ancestor node))
       (not (has-locked-descendant node))))

(define (unlock-all-descendants tree node)
  (define (unlock-descendants node)
    (cond
      [(not (hash-has-key? tree 'children)) (void)]
      [(not (hash-has-key? (hash-ref tree 'children (hash #f)) node)) (void)]
      [else
       (let loop ([children (hash-ref (hash-ref tree 'children (hash #f)) node)])
         (cond
           [(null? children) (void)]
           [else
            (if (is-locked tree (car children))
                (unlock tree (car children)))
            (unlock-descendants (car children))
            (loop (cdr children)))]))]))

  (unlock-descendants node))

(define (lock-tree n parent)
  (let ([tree (make-hash)])
    (hash-set! tree 'parent (make-hash))
    (hash-set! tree 'children (make-hash))

    (for/list ([i (in-range 0 n)])
      (hash-set! tree i #f))

    (for/list ([i (in-range 0 (length parent))])
      (if (not (= (list-ref parent i) -1))
          (begin
            (if (not (hash-has-key? (hash-ref tree 'children (hash #f)) (list-ref parent i)))
                (hash-set! (hash-ref tree 'children (hash #f)) (list-ref parent i) '()))

            (hash-set! (hash-ref tree 'children (hash #f)) (list-ref parent i)
                       (append (hash-ref (hash-ref tree 'children (hash #f)) (list-ref parent i)) (list i)))

            (hash-set! (hash-ref tree 'parent (hash #f)) i (list-ref parent i)))))

    tree))

(define (lock-node tree node)
  (if (and (not (is-locked tree node)) (lock-ancestor-descendant tree node))
      (begin (lock tree node) #t)
      #f))

(define (unlock-node tree node)
  (if (is-locked tree node)
      (begin (unlock tree node) #t)
      #f))

(define (upgrade-node tree node)
  (if (and (not (is-locked tree node)) (lock-ancestor-descendant tree node))
      (let ([locked-descendants (filter (lambda (descendant) (is-locked tree descendant))
                                         (let loop ([nodes (hash-ref (hash-ref tree 'children (hash #f)) node '())]
                                                    [acc '()])
                                           (cond
                                             [(null? nodes) acc]
                                             [else (loop (append (hash-ref (hash-ref tree 'children (hash #f)) (car nodes) '()) (cdr nodes))
                                                         (cons (car nodes) acc))]))
                                         )])
        (if (not (null? locked-descendants))
            (begin
              (lock tree node)
              (for-each (lambda (descendant) (unlock tree descendant)) locked-descendants)
              #t)
            #f))
      #f))

(define (operations-on-tree n parent queries)
  (let ([tree (lock-tree n parent)])
    (map (lambda (query)
           (let ([type (car query)]
                 [node (cadr query)])
             (cond
               [(= type 1) (lock-node tree node)]
               [(= type 2) (unlock-node tree node)]
               [(= type 3) (upgrade-node tree node)]
               [else #f])))
         queries)))