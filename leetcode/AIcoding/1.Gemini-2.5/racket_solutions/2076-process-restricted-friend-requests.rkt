(define (process-restricted-friend-requests n restrictions requests)
  (define parent (build-vector n (lambda (i) i)))
  (define forbidden-sets (build-vector n (lambda (i) (make-hash-set))))

  (for ([r restriction restrictions])
    (define r1 (car r))
    (define r2 (cadr r))
    (hash-set-add! (vector-ref forbidden-sets r1) r2)
    (hash-set-add! (vector-ref forbidden-sets r2) r1))

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ([root (find (vector-ref parent i))])
          (vector-set! parent i root)
          root)))

  (define (merge-forbidden-sets root1 root2)
    (define set1 (vector-ref forbidden-sets root1))
    (define set2 (vector-ref forbidden-sets root2))
    (hash-set-for-each (lambda (r) (hash-set-add! set1 r)) set2))

  (define results-rev '())

  (for ([req requests])
    (define p1 (car req))
    (define p2 (cadr req))

    (define root1 (find p1))
    (define root2 (find p2))

    (if (= root1 root2)
        (set! results-rev (cons #t results-rev))
        (let ([can-merge? #t])
          (when (or (hash-set-contains? (vector-ref forbidden-sets root1) root2)
                    (hash-set-contains? (vector-ref forbidden-sets root2) root1))
            (set! can-merge? #f))

          (if can-merge?
              (begin
                (vector-set! parent root2 root1)
                (merge-forbidden-sets root1 root2)
                (set! results-rev (cons #t results-rev)))
              (set! results-rev (cons #f results-rev))))))
  (reverse results-rev))