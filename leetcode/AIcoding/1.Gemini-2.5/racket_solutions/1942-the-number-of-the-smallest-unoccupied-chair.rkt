#lang racket

(require data/heap)
(require racket/hash)

(define (the-number-of-the-smallest-unoccupied-chair times targetFriend)
  (let* ([num-friends (length times)]
         [events (for/list ([i (in-range num-friends)]
                            [time-pair times])
                   (list (list (car time-pair) 1 i) ; arrival event: (time type friend-id), type 1 for arrival
                         (list (cadr time-pair) 0 i))) ; departure event: (time type friend-id), type 0 for departure
         ]
         [all-events (sort (flatten events)
                           (lambda (e1 e2)
                             (let ([time1 (car e1)]
                                   [time2 (car e2)])
                               (if (= time1 time2)
                                   (< (cadr e1) (cadr e2)) ; Departures (type 0) sort before arrivals (type 1) at same time
                                   (< time1 time2)))))
         ]
         [available-chairs (make-heap <)] ; min-heap for smallest chair number
         [friend-chair-map (make-hash)] ; maps friend-id to chair-num
         [target-chair #f])

    (for ([i (in-range num-friends)])
      (heap-add! available-chairs i))

    (for ([event all-events])
      (let ([type (cadr event)]
            [friend-id (caddr event)])
        (if (= type 1) ; Arrival event
            (begin
              (let ([chair-num (heap-min available-chairs)])
                (heap-remove-min! available-chairs)
                (hash-set! friend-chair-map friend-id chair-num)
                (when (= friend-id targetFriend)
                  (set! target-chair chair-num))))
            ; Departure event
            (begin
              (let ([chair-num (hash-ref friend-chair-map friend-id)])
                (hash-remove! friend-chair-map friend-id)
                (heap-add! available-chairs chair-num))))))
    target-chair))