#lang racket

(require racket/queue)
(require racket/hash)

(define (oranges-rotting grid)
  (define m (length grid))
  (define n (length (car grid)))

  (define fresh-oranges 0)
  (define q (make-queue))
  (define visited (make-hash))

  (define dr (list -1 1 0 0))
  (define dc (list 0 0 -1 1))

  (for ([r (in-range m)])
    (for ([c (in-range n)])
      (define cell-val (list-ref (list-ref grid r) c))
      (cond
        [(= cell-val 1) (set! fresh-oranges (add1 fresh-oranges))]
        [(= cell-val 2)
         (queue-push! q (list r c 0))
         (hash-set! visited (list r c) #t)])))

  (define max-time 0)

  (unless (zero? fresh-oranges)
    (while (not (queue-empty? q))
      (define current (queue-pop! q))
      (define r (list-ref current 0))
      (define c (list-ref current 1))
      (define t (list-ref current 2))

      (set! max-time (max max-time t))

      (for ([i (in-range 4)])
        (define nr (+ r (list-ref dr i)))
        (define nc (+ c (list-ref dc i)))

        (when (and (>= nr 0) (< nr m)
                   (>= nc 0) (< nc n))
          (when (and (= (list-ref (list-ref grid nr) nc) 1)
                     (not (hash-has-key? visited (list nr nc))))
            (set! fresh-oranges (sub1 fresh-oranges))
            (hash-set! visited (list nr nc) #t)
            (queue-push! q (list nr nc (add1 t))))))))

  (if (zero? fresh-oranges)
      max-time
      -1))