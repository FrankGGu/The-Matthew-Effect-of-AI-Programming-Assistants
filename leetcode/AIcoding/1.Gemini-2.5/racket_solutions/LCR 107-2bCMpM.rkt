(require data/queue)

(define (update-matrix mat)
  (define m (length mat))
  (define n (length (car mat)))

  (define dist (make-vector m))
  (for ([i (in-range m)])
    (vector-set! dist i (make-vector n)))

  (define q (make-queue))

  (define +infinity (add1 (* m n)))

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (if (= (list-ref (list-ref mat r) c) 0)
          (begin
            (vector-set! (vector-ref dist r) c 0)
            (enqueue! q (list r c)))
          (vector-set! (vector-ref dist r) c +infinity))))

  (define directions '((0 1) (0 -1) (1 0) (-1 0)))

  (let loop ()
    (when (not (queue-empty? q))
      (define current (dequeue! q))
      (define r (car current))
      (define c (cadr current))
      (define current-dist (vector-ref (vector-ref dist r) c))

      (for ([dir directions])
        (define dr (car dir))
        (define dc (cadr dir))
        (define nr (+ r dr))
        (define nc (+ c dc))

        (when (and (>= nr 0) (< nr m)
                   (>= nc 0) (< nc n))
          (when (> (vector-ref (vector-ref dist nr) nc) (+ current-dist 1))
            (vector-set! (vector-ref dist nr) nc (+ current-dist 1))
            (enqueue! q (list nr nc)))))
      (loop)))

  (for/list ([row-vec (in-vector dist)])
    (for/list ([val (in-vector row-vec)])
      val)))