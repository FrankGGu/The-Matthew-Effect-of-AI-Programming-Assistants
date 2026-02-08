#lang racket

(define (latest-time-to-catch-bus buses passengers capacity)
  (define sorted-buses (sort buses <))
  (define sorted-passengers (sort passengers <))

  (define passenger-arrival-set (make-hash))
  (for-each (lambda (p-time) (hash-set! passenger-arrival-set p-time #t)) sorted-passengers)

  (define num-buses (length sorted-buses))
  (define num-passengers (length sorted-passengers))

  (define p-idx 0)
  (define final-latest-arrival-candidate 0)

  (define last-bus-passengers-count 0)
  (define last-passenger-boarded-on-last-bus-time -1)

  (for ([b-idx (in-range num-buses)])
    (define current-bus-arrival-time (list-ref sorted-buses b-idx))
    (define current-bus-passengers-count-for-this-bus 0)
    (define current-bus-last-boarded-p-time -1)

    (let loop ()
      (when (and (< p-idx num-passengers)
                 (< current-bus-passengers-count-for-this-bus capacity)
                 (<= (list-ref sorted-passengers p-idx) current-bus-arrival-time))
        (set! current-bus-last-boarded-p-time (list-ref sorted-passengers p-idx))
        (set! p-idx (+ p-idx 1))
        (set! current-bus-passengers-count-for-this-bus (+ current-bus-passengers-count-for-this-bus 1))
        (loop)))

    (when (= b-idx (- num-buses 1))
      (set! last-bus-passengers-count current-bus-passengers-count-for-this-bus)
      (set! last-passenger-boarded-on-last-bus-time current-bus-last-boarded-p-time)))

  (cond
    [(< last-bus-passengers-count capacity)
     (set! final-latest-arrival-candidate (list-ref sorted-buses (- num-buses 1)))
     (let loop-decrement ()
       (when (hash-has-key? passenger-arrival-set final-latest-arrival-candidate)
         (set! final-latest-arrival-candidate (- final-latest-arrival-candidate 1))
         (loop-decrement)))]
    [else
     (set! final-latest-arrival-candidate (- last-passenger-boarded-on-last-bus-time 1))
     (let loop-decrement ()
       (when (hash-has-key? passenger-arrival-set final-latest-arrival-candidate)
         (set! final-latest-arrival-candidate (- final-latest-arrival-candidate 1))
         (loop-decrement)))]
    )

  final-latest-arrival-candidate)