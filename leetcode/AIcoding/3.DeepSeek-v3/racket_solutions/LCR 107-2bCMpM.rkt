(define/contract (update-matrix mat)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let* ([m (length mat)]
         [n (if (zero? m) 0 (length (car mat)))]
         [dist (make-vector m (make-vector n +inf.0))]
         [q (make-queue)])
    (for ([i (in-range m)])
      (for ([j (in-range n)])
        (when (zero? (list-ref (list-ref mat i) j))
          (vector-set! (vector-ref dist i) j 0)
          (enqueue! q (cons i j))))
    (let loop ()
      (unless (queue-empty? q)
        (let ([cell (dequeue! q)])
          (let ([i (car cell)]
                [j (cdr cell)])
            (for ([dir (in-list '((0 . 1) (0 . -1) (1 . 0) (-1 . 0))])
              (let ([ni (+ i (car dir))]
                    [nj (+ j (cdr dir))])
                (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n))
                  (when (> (vector-ref (vector-ref dist ni) nj)
                           (+ (vector-ref (vector-ref dist i) j) 1))
                    (vector-set! (vector-ref dist ni) nj (+ (vector-ref (vector-ref dist i) j) 1))
                    (enqueue! q (cons ni nj)))))))
        (loop)))
    (for/list ([i (in-range m)])
      (for/list ([j (in-range n)])
        (vector-ref (vector-ref dist i) j)))))