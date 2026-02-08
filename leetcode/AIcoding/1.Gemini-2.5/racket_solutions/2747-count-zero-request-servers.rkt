#lang racket

(define (count-zero-request-servers n logs queries x)
  ;; 1. Sort logs by time.
  ;; Each log is (list server_id time).
  (define sorted-logs (sort logs (lambda (l1 l2) (< (second l1) (second l2)))))

  ;; 2. Pair queries with their original indices and sort them by query time.
  ;; Each indexed-query is (list query_time original_index).
  (define indexed-queries
    (map (lambda (q i) (list q i)) queries (range (length queries))))
  (define sorted-indexed-queries
    (sort indexed-queries (lambda (iq1 iq2) (< (first iq1) (first iq2)))))

  ;; 3. Initialize result array (mutable vector for efficient updates by index).
  (define ans (make-vector (length queries) 0))

  ;; 4. Initialize pointers and data structures for the sliding window.
  ;; server-request-counts: Hash table mapping server_id to the number of requests
  ;;                        it has received within the current window.
  ;; active-servers-count: Number of unique servers that have at least one request
  ;;                       within the current window.
  (define server-request-counts (make-hash))
  (define active-servers-count 0)
  (define log-left-ptr 0)
  (define log-right-ptr 0)
  (define num-logs (length sorted-logs))

  ;; Helper function to add a log entry to the window.
  (define (add-log log-entry)
    (define server-id (first log-entry))
    (define current-count (hash-ref server-request-counts server-id 0))
    (hash-set! server-request-counts server-id (+ current-count 1))
    ;; If this server just became active, increment active-servers-count.
    (when (= current-count 0)
      (set! active-servers-count (+ active-servers-count 1))))

  ;; Helper function to remove a log entry from the window.
  (define (remove-log log-entry)
    (define server-id (first log-entry))
    ;; current-count must be > 0 if we are removing a log that was previously added.
    (define current-count (hash-ref server-request-counts server-id))
    (hash-set! server-request-counts server-id (- current-count 1))
    ;; If this server just became inactive (no more requests in window),
    ;; decrement active-servers-count.
    (when (= (- current-count 1) 0)
      (set! active-servers-count (- active-servers-count 1))))

  ;; 5. Iterate through the sorted queries.
  (for-each
   (lambda (indexed-query)
     (define q-time (first indexed-query))
     (define q-idx (second indexed-query))
     (define window-start-time (- q-time x))

     ;; Move the right pointer: Add logs whose time is within the current query's window [window-start-time, q-time].
     ;; Logs are added if their time is less than or equal to q-time.
     (while (< log-right-ptr num-logs)
       (define current-log (list-ref sorted-logs log-right-ptr))
       (define log-time (second current-log))
       (when (> log-time q-time)
         (break)) ; This log (and subsequent ones) are too new for the current query.
       (add-log current-log)
       (set! log-right-ptr (+ log-right-ptr 1)))

     ;; Move the left pointer: Remove logs whose time is outside the current query's window (i.e., < window-start-time).
     (while (< log-left-ptr log-right-ptr)
       (define current-log (list-ref sorted-logs log-left-ptr))
       (define log-time (second current-log))
       (when (>= log-time window-start-time)
         (break)) ; This log (and subsequent ones) are within or at the start of the window.
       (remove-log current-log)
       (set! log-left-ptr (+ log-left-ptr 1)))

     ;; Calculate the number of zero-request servers for the current query.
     ;; This is total servers (n) minus servers that have requests in the window.
     (vector-set! ans q-idx (- n active-servers-count)))
   sorted-indexed-queries)

  ;; 6. Convert the result vector to a list and return.
  (vector->list ans))