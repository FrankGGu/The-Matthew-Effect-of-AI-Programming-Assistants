#lang racket

(require racket/vector
         racket/queue)

(define (highest-peak isWater)
  (define rows (length isWater))
  (define cols (length (car isWater)))

  (define heights (make-vector rows))
  (for ([r (in-range rows)])
    (vector-set! heights r (make-vector cols -1)))

  (define q (make-queue))

  (for ([r (in-range rows)])
    (for ([c (in-range cols)])
      (when (= (list-ref (list-ref isWater r) c) 1)
        (vector-set! (vector-ref heights r) c 0)
        (queue-push! q (list r c)))))

  (define dr (vector -1 1 0 0))
  (define dc (vector 0 0 -1 1))

  (while (not (queue-empty? q))
    (define-values (r c) (apply values (queue-pop! q)))

    (for ([i (in-range 4)])
      (define nr (+ r (vector-ref dr i)))
      (define nc (+ c (vector-ref dc i)))

      (when (and (>= nr 0) (< nr rows)
                 (>= nc 0) (< nc cols))
        (when (= (vector-ref (vector-ref heights nr) nc) -1)
          (vector-set! (vector-ref heights nr) nc (+ (vector-ref (vector-ref heights r) c) 1))
          (queue-push! q (list nr nc))))))

  (for/list ([row-vec (in-vector heights)])
    (vector->list row-vec)))