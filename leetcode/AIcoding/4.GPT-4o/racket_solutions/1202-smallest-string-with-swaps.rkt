(define (smallest-string-with-swaps s pairs)
  (define (find parent x)
    (if (equal? (list-ref parent x) x)
        x
        (set! (list-ref parent x) (find parent (list-ref parent x)))
        (list-ref parent x)))

  (define (union parent rank x y)
    (define rootX (find parent x))
    (define rootY (find parent y))
    (if (not (equal? rootX rootY))
        (if (> (list-ref rank rootX) (list-ref rank rootY))
            (set! (list-ref parent rootY) rootX)
            (begin
              (set! (list-ref parent rootX) rootY)
              (if (= (list-ref rank rootX) (list-ref rank rootY))
                  (set! (list-ref rank rootY) (+ (list-ref rank rootY) 1))))))
    parent)

  (define n (string-length s))
  (define parent (build-vector n (lambda (i) i)))
  (define rank (build-vector n 0))

  (for-each (lambda (pair)
              (union parent rank (car pair) (cadr pair)))
            pairs)

  (define groups (make-hash))

  (for ([i (in-range n)])
    (define root (find parent i))
    (hash-set! groups root (if (hash-has-key? groups root)
                                (vector-append (hash-ref groups root) (vector (string-ref s i)))
                                (vector (string-ref s i)))))

  (define result (make-vector n))

  (for-each (lambda (group)
              (define sorted (sort (vector->list group) char<?))
              (for ([i (in-range (vector-length group))])
                (vector-set! result (car (vector->list group)) (list-ref sorted i))))
            (hash-values groups))

  (list->string (vector->list result)))