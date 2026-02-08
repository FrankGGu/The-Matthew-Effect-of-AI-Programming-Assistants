#lang racket

(require data/queue)
(require data/hash-set)

(define (shortest-path grid k)
  (define m (length grid))
  (define n (length (car grid)))

  (when (and (= m 1) (= n 1))
    (if (= (list-ref (list-ref grid 0) 0) 0)
        0
        (if (>= k 1) 0 -1)))

  (define grid-vec (build-vector m (lambda (i) (list->vector (list-ref grid i)))))

  (define (get-cell r c)
    (vector-ref (vector-ref grid-vec r) c))

  (define (in-bounds? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  (define q (make-queue))
  (define visited (make-hash-set))

  (queue-enqueue! q (list 0 0 k 0))
  (hash-set-add! visited (list 0 0 k))

  (define dr (list 0 0 1 -1))
  (define dc (list 1 -1 0 0))

  (let bfs-loop ()
    (if (queue-empty? q)
        -1
        (let* ((current (queue-dequeue! q))
               (r (list-ref current 0))
               (c (list-ref current 1))
               (elims (list-ref current 2))
               (steps (list-ref current 3)))

          (if (and (= r (- m 1)) (= c (- n 1)))
              steps
              (begin
                (for ([i (in-range 4)])
                  (define nr (+ r (list-ref dr i)))
                  (define nc (+ c (list-ref dc i)))

                  (when (in-bounds? nr nc)
                    (let* ((cell-val (get-cell nr nc))
                           (new-elims (if (= cell-val 1) (- elims 1) elims)))

                      (when (>= new-elims 0)
                        (define next-state-key (list nr nc new-elims))
                        (unless (hash-set-contains? visited next-state-key)
                          (hash-set-add! visited next-state-key)
                          (queue-enqueue! q (list nr nc new-elims (add1 steps))))))))
                (bfs-loop))))))