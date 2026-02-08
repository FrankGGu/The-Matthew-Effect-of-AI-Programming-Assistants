(define set-struct (struct set-struct (s) #:mutable))

(define smallest-infinite-set
  (let ((set-obj (set-struct (set))))
    (define (popSmallest)
      (let loop ((i 1))
        (if (set-member? (set-struct-s set-obj) i)
            (loop (+ i 1))
            (begin
              (set-struct-s-set! set-obj (set-add (set-struct-s set-obj) i))
              i))))
    (define (addBack val)
      (set-struct-s-set! set-obj (set-remove (set-struct-s set-obj) val)))
    (λ (op arg)
      (cond
        [(equal? op 'popSmallest) (popSmallest)]
        [(equal? op 'addBack) (addBack arg)]))))