#lang racket

(require data/queue)

(define (num-buses routes source target)
  ;; Edge case: if source is target, no buses needed.
  (if (= source target)
      0
      (let ()
        ;; Map: stop_id -> list of route_ids that visit this stop
        (define stop-to-routes (make-hash))

        ;; Populate stop-to-routes map
        (for ([route-idx (in-range (length routes))]
              [route (in-list routes)])
          (for ([stop-id (in-list route)])
            (hash-update! stop-to-routes stop-id
                          (lambda (lst) (cons route-idx lst))
                          '())))

        ;; Handle cases where source or target stops are not on any route.
        ;; If source is not on any route, it's impossible to start.
        (if (not (hash-has-key? stop-to-routes source))
            -1
            ;; If target is not on any route, it's impossible to reach (unless source == target, handled).
            (if (not (hash-has-key? stop-to-routes target))
                -1
                (let ()
                  ;; Queue for BFS: stores route-ids
                  (define q (make-queue))
                  ;; Set of visited routes (to avoid cycles and redundant processing)
                  (define visited-routes (make-hash)) ; Using hash table as a set

                  ;; Initialize BFS with routes starting from 'source'
                  (define initial-routes (hash-ref stop-to-routes source '()))

                  (for ([route-idx (in-list initial-routes)])
                    (enqueue! q route-idx)
                    (hash-set! visited-routes route-idx #t))

                  (define buses-taken 1)

                  ;; BFS loop using a named let for recursion
                  (let loop ()
                    (if (queue-empty? q)
                        -1 ; If queue is empty, target not reachable
                        (let ([current-level-size (queue-size q)])
                          (define found-target-in-level #f) ; Flag to check if target is found in current level

                          (for ([_ (in-range current-level-size)])
                            (define current-route-idx (dequeue! q))

                            ;; Check if target is in the current route
                            (for ([stop-id (in-list (list-ref routes current-route-idx))])
                              (when (= stop-id target)
                                (set! found-target-in-level #t))) ; Set flag

                            ;; Explore neighbor routes (routes that share a stop with current-route-idx)
                            (for ([stop-id (in-list (list-ref routes current-route-idx))])
                              (for ([next-route-idx (in-list (hash-ref stop-to-routes stop-id '()))])
                                (when (not (hash-has-key? visited-routes next-route-idx))
                                  (hash-set! visited-routes next-route-idx #t)
                                  (enqueue! q next-route-idx)))))

                          (if found-target-in-level
                              buses-taken ; Target found in this level, return current buses_taken
                              (begin
                                (set! buses-taken (+ buses-taken 1))
                                (loop))))))) ; Continue BFS to the next level

                  ;; Start the BFS loop
                  (loop))))))