#lang racket

(require racket/vector)
(require racket/list)
(require racket/queue)
(require racket/hash)

(define (detonate-the-maximum-bombs bombs)
  (let* ([n (length bombs)]
         [adj (make-vector n '())]) ; Adjacency list for each bomb

    ;; Handle edge case: no bombs
    (when (zero? n)
      (error 'detonate-the-maximum-bombs "No bombs provided."))

    ;; Build the graph
    (for ([i (in-range n)])
      (let* ([bomb-i (list-ref bombs i)]
             [xi (list-ref bomb-i 0)]
             [yi (list-ref bomb-i 1)]
             [ri (list-ref bomb-i 2)])
        (for ([j (in-range n)])
          (unless (= i j)
            (let* ([bomb-j (list-ref bombs j)]
                   [xj (list-ref bomb-j 0)]
                   [yj (list-ref bomb-j 1)]
                   [dist-sq (+ (expt (- xj xi) 2) (expt (- yj yi) 2))])
              (when (<= dist-sq (expt ri 2))
                (vector-set! adj i (cons j (vector-ref adj i)))))))))

    ;; Perform BFS from each bomb
    (let ([max-detonated 0])
      (for ([i (in-range n)])
        (let ([q (make-queue)] ; BFS queue
              [visited (make-hash)]) ; Visited set for current traversal
          (queue-add! q i)
          (hash-set! visited i #t)
          (let loop ()
            (when (not (queue-empty? q))
              (let ([current-bomb (queue-remove! q)])
                (for-each (lambda (neighbor)
                            (unless (hash-has-key? visited neighbor)
                              (hash-set! visited neighbor #t)
                              (queue-add! q neighbor)))
                          (vector-ref adj current-bomb)))
              (loop)))
          (set! max-detonated (max max-detonated (hash-count visited)))))
      max-detonated)))