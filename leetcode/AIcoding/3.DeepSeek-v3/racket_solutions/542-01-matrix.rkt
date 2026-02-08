(define/contract (update-matrix mat)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?))
  (let* ([m (length mat)]
         [n (length (car mat))]
         [dist (make-list m (make-list n +inf.0))]
         [q (make-queue)])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (when (zero? (list-ref (list-ref mat i) j))
          (list-set! (list-ref dist i) j 0)
          (enqueue! q (cons i j))))
    (let loop ()
      (unless (queue-empty? q)
        (let ([cell (dequeue! q)]
              [dirs '((0 . 1) (0 . -1) (1 . 0) (-1 . 0))])
          (for ([dir (in-list dirs)])
            (let ([i (+ (car cell) (car dir))]
                  [j (+ (cdr cell) (cdr dir))])
              (when (and (>= i 0) (< i m) (>= j 0) (< j n))
                (let ([new-dist (+ 1 (list-ref (list-ref dist (car cell)) (cdr cell)))])
                  (when (< new-dist (list-ref (list-ref dist i) j))
                    (list-set! (list-ref dist i) j new-dist)
                    (enqueue! q (cons i j)))))))
        (loop)))
    dist))