(define/contract (highest-peak is-water)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let* ([m (length is-water)]
         [n (if (zero? m) 0 (length (car is-water)))]
         [dirs '((0 . 1) (1 . 0) (0 . -1) (-1 . 0))]
         [queue (make-queue)]
         [result (for/list ([i (in-range m)])
                   (for/list ([j (in-range n)])
                     (if (zero? (list-ref (list-ref is-water i) j))
                         -1
                         0)))]
         [visited (make-hash)])
    (for ([i (in-range m)])
    (for ([j (in-range n)])
    (for ([i (in-range m)])
    (for ([j (in-range n)])
      (when (= 1 (list-ref (list-ref is-water i) j))
        (enqueue! queue (cons i j))
        (hash-set! visited (cons i j) #t)))
    (let loop ()
      (unless (queue-empty? queue)
        (let* ([cell (dequeue! queue)]
               [i (car cell)]
               [j (cdr cell)]
               [current (list-ref (list-ref result i) j)])
        (for ([dir dirs])
          (let ([ni (+ i (car dir))]
                [nj (+ j (cdr dir))])
            (when (and (>= ni 0) (< ni m) (>= nj 0) (< nj n)
                       (not (hash-ref visited (cons ni nj) #f)))
              (hash-set! visited (cons ni nj) #t)
              (set! result (list-set result ni (list-set (list-ref result ni) nj (+ current 1))))
              (enqueue! queue (cons ni nj)))))
        (loop)))
    result))