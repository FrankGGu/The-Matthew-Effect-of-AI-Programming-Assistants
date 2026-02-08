#lang racket/base

(require racket/for)

(define (game-of-life board)
  (define rows (vector-length board))
  (when (> rows 0)
    (define cols (vector-length (vector-ref board 0)))

    (define (get-live-neighbours r c)
      (define count 0)
      (for* ([dr (in-range -1 2)]
             [dc (in-range -1 2)])
        (unless (and (= dr 0) (= dc 0))
          (define nr (+ r dr))
          (define nc (+ c dc))
          (when (and (>= nr 0) (< nr rows)
                     (>= nc 0) (< nc cols))
            (define cell-state (vector-ref (vector-ref board nr) nc))
            (when (or (= cell-state 1) (= cell-state 2))
              (set! count (+ count 1))))))
      count)

    (for* ([r (in-range rows)]
           [c (in-range cols)])
      (define live-neighbours (get-live-neighbours r c))
      (define current-state (vector-ref (vector-ref board r) c))

      (cond
        [(= current-state 1)
         (when (or (< live-neighbours 2) (> live-neighbours 3))
           (vector-set! (vector-ref board r) c 2))]
        [(= current-state 0)
         (when (= live-neighbours 3)
           (vector-set! (vector-ref board r) c 3))])))

  (for* ([r (in-range rows)]
         [c (in-range cols)])
    (define state (vector-ref (vector-ref board r) c))
    (cond
      [(= state 2)
       (vector-set! (vector-ref board r) c 0)]
      [(= state 3)
       (vector-set! (vector-ref board r) c 1)])))
  (void))