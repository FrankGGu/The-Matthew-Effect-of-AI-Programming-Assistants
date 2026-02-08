(define (smallestString s pairs)
  (define n (string-length s))
  (define parent (make-vector n))

  (define (find x)
    (if (not (= (vector-ref parent x) x))
        (let ((root (find (vector-ref parent x))))
          (vector-set! parent x root)
          root)
        x))

  (define (union x y)
    (define rootX (find x))
    (define rootY (find y))
    (if (not (= rootX rootY))
        (vector-set! parent rootY rootX)))

  (for-each (lambda (pair)
              (union (car pair) (cadr pair)))
            pairs)

  (define groups (make-hash))

  (for ([i (in-range n)])
    (define root (find i))
    (hash-set! groups root (cons i (hash-ref groups root (lambda () '())))))

  (define result (string->list s))

  (for-each (lambda (indices)
              (define chars (map (lambda (i) (list-ref result i)) indices))
              (define sorted-chars (sort chars string<?))
              (for ([i (in-range (length indices))])
                (list-set! result (list-ref indices i) (list-ref sorted-chars i))))
            (hash->list groups))

  (list->string result))