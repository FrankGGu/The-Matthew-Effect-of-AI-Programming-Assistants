(define (process-restricted-friend-requests n restrictions requests)
  (define parents (vector-fill n -1))

  (define (find x)
    (if (= (vector-ref parents x) -1)
        x
        (let ((root (find (vector-ref parents x))))
          (vector-set! parents x root)
          root)))

  (define (union x y)
    (let ((rootX (find x))
          (rootY (find y)))
      (when (not (= rootX rootY))
        (vector-set! parents rootX rootY))))

  (define (can-friend x y)
    (and (not (equal? (find x) (find y)))
         (not (or (member (list x y) restrictions)
                  (member (list y x) restrictions)))))

  (define result '())
  (for-each (lambda (request)
              (if (can-friend (car request) (cadr request))
                  (begin
                    (union (car request) (cadr request))
                    (set! result (cons 1 result)))
                  (set! result (cons 0 result))))
            requests)
  (reverse result))