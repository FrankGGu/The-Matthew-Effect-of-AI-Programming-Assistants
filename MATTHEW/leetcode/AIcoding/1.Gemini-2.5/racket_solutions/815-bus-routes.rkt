#lang racket
(require racket/queue)
(require racket/hash)

(define (num-buses-to-destination routes source target)
  (define (solve-bus-routes-internal routes source target)
    ;; Handle edge case: if source and target are the same, 0 buses needed.
    (when (= source target)
      (error 'found-target 0))

    ;; Map each stop to a list of route indices that pass through it.
    ;; Key: stop ID (integer), Value: list of route indices (integers)
    (define stop-to-routes (make-hash))
    (for ([route-idx (in-range (length routes))]
          [route (in-list routes)])
      (for ([stop route])
        (hash-set! stop-to-routes stop
                   (cons route-idx (hash-ref stop-to-routes stop '())))))

    ;; Queue for BFS: stores (route-idx . buses-taken) pairs.
    ;; Each element is a pair where car is route-idx and cdr is buses-taken.
    (define q (make-queue))

    ;; Set of visited route indices to avoid cycles and redundant processing.
    ;; Key: route index (integer), Value: #t (boolean)
    (define visited-routes (make-hash))

    ;; Initialize BFS with routes that pass through the source stop.
    ;; If source stop is not in any route, (hash-ref stop-to-routes source '()) returns '(),
    ;; and the loop for initial-route-idx will not run, leading to an -1 result.
    (for ([initial-route-idx (hash-ref stop-to-routes source '())])
      (unless (hash-has-key? visited-routes initial-route-idx)
        (hash-set! visited-routes initial-route-idx #t)
        (queue-put! q (cons initial-route-idx 1))))

    ;; Perform BFS
    (let loop ()
      (if (queue-empty? q)
          -1 ; Target not reachable after exploring all possibilities
          (let* ([current-pair (queue-get! q)]
                 [current-route-idx (car current-pair)]
                 [buses-taken (cdr current-pair)]
                 [current-route (list-ref routes current-route-idx)])

            ;; Check if any stop in the current route is the target.
            (for ([stop current-route])
              (when (= stop target)
                (error 'found-target buses-taken))) ; Early exit with the result

            ;; Explore next routes from current route's stops
            (for ([stop current-route])
              ;; For each stop on the current route, find all other routes
              ;; that also pass through this stop. These are potential next buses.
              (for ([next-route-idx (hash-ref stop-to-routes stop '())])
                (unless (hash-has-key? visited-routes next-route-idx)
                  (hash-set! visited-routes next-route-idx #t)
                  (queue-put! q (cons next-route-idx (+ buses-taken 1))))))
            (loop))))
    )

  ;; Use a custom error handler to catch the 'found-target error and return its value.
  ;; This allows for an efficient early exit from the deep recursion/loop of BFS.
  (with-handlers
      ([exn:fail:user?
        (lambda (e)
          (if (eq? (exn:fail:user-message e) 'found-target)
              (car (exn:fail:user-irritants e)) ; Extract the result (first irritant)
              (raise e)))]) ; Re-raise other errors
    (solve-bus-routes-internal routes source target)))