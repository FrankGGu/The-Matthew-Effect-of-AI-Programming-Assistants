(define (water-bottles capacity bottles target)
  (define (bfs)
    (define q (queue))
    (define visited (make-hash))
    (queue-enqueue! q (list 0 0))
    (hash-set! visited (list 0 0) #t)

    (define (neighbors state)
      (define a (car state))
      (define b (cadr state))
      (define res '())

      ;empty a
      (if (not (hash-has-key? visited (list 0 b)))
          (set! res (cons (list 0 b) res)))
      ;empty b
      (if (not (hash-has-key? visited (list a 0)))
          (set! res (cons (list a 0) res)))
      ;fill a
      (if (not (hash-has-key? visited (list capacity b)))
          (set! res (cons (list capacity b) res)))
      ;fill b
      (if (not (hash-has-key? visited (list a bottles)))
          (set! res (cons (list a bottles) res)))
      ;a to b
      (define pour (min a (- bottles b)))
      (if (not (hash-has-key? visited (list (- a pour) (+ b pour))))
          (set! res (cons (list (- a pour) (+ b pour)) res)))
      ;b to a
      (define pour (min b (- capacity a)))
      (if (not (hash-has-key? visited (list (+ a pour) (- b pour))))
          (set! res (cons (list (+ a pour) (- b pour)) res)))

      res)

    (let loop ()
      (cond
        [(queue-empty? q) #f]
        [else
         (define curr (queue-dequeue! q))
         (define a (car curr))
         (define b (cadr curr))
         (if (= (+ a b) target)
             #t
             (begin
               (for-each
                (lambda (neighbor)
                  (if (not (hash-has-key? visited neighbor))
                      (begin
                        (queue-enqueue! q neighbor)
                        (hash-set! visited neighbor #t))))
                (neighbors curr))
               (loop)))])))

    (if (bfs) #t #f))

  (bfs))