#lang racket

(define (traffic-light green-time)
  (let loop ([time 0] [direction 'north] [green-remaining green-time] [queue (make-hash '((north . 0) (south . 0) (east . 0) (west . 0)))])
    (cond
      [(and (zero? (hash-ref queue 'north))
            (zero? (hash-ref queue 'south))
            (zero? (hash-ref queue 'east))
            (zero? (hash-ref queue 'west))) time]
      [(positive? green-remaining)
       (if (positive? (hash-ref queue direction))
           (loop (add1 time)
                 direction
                 (sub1 green-remaining)
                 (hash-update queue direction sub1))
           (loop (add1 time)
                 direction
                 (sub1 green-remaining)
                 queue))]
      [else
       (let ([next-dir (case direction
                         [(north) 'east]
                         [(south) 'west]
                         [(east) 'south]
                         [(west) 'north])])
         (loop time next-dir green-time queue))])))