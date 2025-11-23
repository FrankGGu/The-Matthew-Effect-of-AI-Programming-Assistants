(define hash-set%
  (class object%
    (init-field (capacity 1024))
    (define table (make-vector capacity #f))

    (define (hash key)
      (remainder (abs (hash-code key)) capacity))

    (define/public (add key)
      (let ((index (hash key)))
        (cond
          [(#f? (vector-ref table index))
           (vector-set! table index (list key))]
          [else
           (let ((lst (vector-ref table index)))
             (unless (member key lst)
               (vector-set! table index (cons key lst))))])))

    (define/public (remove key)
      (let ((index (hash key)))
        (cond
          [(#f? (vector-ref table index))
           #f]
          [else
           (let ((lst (vector-ref table index)))
             (let loop ((lst lst) (prev '()))
               (cond
                 [(null? lst) #f]
                 [(equal? (car lst) key)
                  (if (null? prev)
                      (vector-set! table index (cdr lst))
                      (set-cdr! prev (cdr lst)))
                  #t]
                 [else (loop (cdr lst) lst)])))])))

    (define/public (contains key)
      (let ((index (hash key)))
        (cond
          [(#f? (vector-ref table index))
           #f]
          [else
           (member key (vector-ref table index))])))
    ))

(define (make-hash-set) (new hash-set%))