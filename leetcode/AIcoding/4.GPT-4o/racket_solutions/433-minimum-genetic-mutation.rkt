(define (minMutation start end bank)
  (define (bfs start end bank)
    (define visited (make-hash))
    (define queue (list (list start 0)))
    (hash-set! visited start #t)

    (define (valid-gene gene)
      (for/or ([i (in-range (string-length gene))])
        (for/or ([c '(A C G T)])
          (and (not (= (string-ref gene i) c))
               (string=? (string-append (substring gene 0 i) (string c) (substring gene (+ i 1))) end)))))

    (define (transformable? gene)
      (for/some ([b bank])
        (and (not (hash-has? visited b))
             (valid-gene b))))

    (let loop ()
      (if (null? queue)
          -1
          (let* ([current (car queue)]
                 [current-gene (car current)]
                 [steps (cadr current)]
                 [next-genes (filter transformable? bank)])
            (for-each (lambda (gene)
                        (hash-set! visited gene #t)
                        (set! queue (append (cdr queue) (list (list gene (+ steps 1))))))
                      next-genes)
            (if (equal? current-gene end)
                steps
                (loop))))))

  (if (not (member end bank))
      -1
      (bfs start end bank)))