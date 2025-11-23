#lang racket

(require srfi/1)

(define (analyze-subscription-conversion events)
  (let* ([user-events (group-by (lambda (event) (car event)) events)]
         [converted-users
          (filter
           (lambda (user-id-and-events)
             (let* ([user-specific-events (cdr user-id-and-events)]
                    [sorted-events (sort user-specific-events
                                         (lambda (e1 e2)
                                           (string<? (list-ref e1 2) (list-ref e2 2)))))]
                    [state 'initial])
               (eq? 'converted
                    (foldl
                     (lambda (event current-state)
                       (let ([event-type (list-ref event 1)])
                         (case current-state
                           ['initial
                            (if (string=? event-type "trial_start") 'saw-trial 'initial)]
                           ['saw-trial
                            (if (string=? event-type "subscribe") 'converted 'saw-trial)]
                           ['converted 'converted])))
                     state
                     sorted-events))))
           user-events)])
    (length converted-users)))