(define (count-pairs (n servers edges))
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)) (w (caddr edge)))
                (vector-set! adj u (cons (list v w) (vector-ref adj u)))
                (vector-set! adj v (cons (list u w) (vector-ref adj v)))))
            edges)

  (define (dfs u parent)
    (define paths (list))
    (define (explore v w)
      (cond
        [(>= w servers) (void)]
        [else
         (set! paths (cons w paths))
         (for-each (lambda (neighbor)
                     (let ((neighbor-node (car neighbor)) (neighbor-weight (cadr neighbor)))
                       (when (not (= neighbor-node u))
                         (explore neighbor-node (+ w neighbor-weight)))))
                   (vector-ref adj v))]))

    (for-each (lambda (neighbor)
                (let ((neighbor-node (car neighbor)) (neighbor-weight (cadr neighbor)))
                  (when (not (= neighbor-node parent))
                    (explore neighbor-node neighbor-weight))))
              (vector-ref adj u))

    paths)

  (define count 0)
  (for ([i (in-range n)])
    (when (vector-member? servers i)
      (let ((paths (dfs i -1)))
        (define path-counts (make-hash))
        (for-each (lambda (path)
                    (hash-update! path-counts path (lambda (x) (+ x 1)) 1))
                  paths)
        (define sum 0)
        (for ([path (in-list paths)])
          (hash-update! path-counts path (lambda (x) (- x 1)) 0)
          (set! sum (+ sum (hash-ref path-counts (- servers path) 0))))
        (set! count (+ count sum)))))

  (/ count 2))

(define (vector-member? vec val)
  (let loop ([i 0])
    (cond
      [(>= i (vector-length vec)) #f]
      [(= (vector-ref vec i) val) #t]
      [else (loop (+ i 1))])))