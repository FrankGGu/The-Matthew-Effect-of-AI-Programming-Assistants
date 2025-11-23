(define (count-subtrees-with-max-distance cities edges)
  (define n cities)
  (define adj (make-vector n (list)))
  (for-each (lambda (edge)
              (let ((u (car edge)) (v (cadr edge)))
                (vector-set! adj (- u 1) (cons (- v 1) (vector-ref adj (- u 1))))
                (vector-set! adj (- v 1) (cons (- u 1) (vector-ref adj (- v 1))))))
            edges)

  (define (bfs start mask)
    (define q (queue))
    (enqueue! q (cons start 0))
    (define visited (make-vector n #f))
    (vector-set! visited start #t)
    (define farthest-node start)
    (define max-dist 0)

    (let loop ()
      (if (queue-empty? q)
          (values farthest-node max-dist)
          (let ((curr (dequeue! q)))
            (let ((node (car curr)) (dist (cdr curr)))
              (if (> dist max-dist)
                  (begin
                    (set! max-dist dist)
                    (set! farthest-node node)))
              (for-each (lambda (neighbor)
                          (if (and (bitwise-bit-set? mask neighbor) (not (vector-ref visited neighbor)))
                              (begin
                                (enqueue! q (cons neighbor (+ dist 1)))
                                (vector-set! visited neighbor #t)))))
                        (vector-ref adj node))
              (loop)))))

  (define (diameter mask)
    (let-values ( (farthest-node1 _) (void) ) (bfs (find-first-set mask) mask))
    (let-values ( (void farthest-dist) (bfs farthest-node1 mask))
      farthest-dist))

  (define (find-first-set mask)
    (let loop ((i 0))
      (if (bitwise-bit-set? mask i)
          i
          (loop (+ i 1)))))

  (define result (make-vector (sub1 n) 0))

  (for ((mask (in-range 1 (expt 2 n))))
    (define count 0)
    (for ((i (in-range n)))
      (if (bitwise-bit-set? mask i)
          (set! count (+ count 1))))

    (if (> count 1)
        (let ((dist (diameter mask)))
          (if (<= 1 dist n)
              (vector-set! result (- dist 1) (+ (vector-ref result (- dist 1)) 1))))))

  (vector->list result))