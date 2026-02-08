#lang racket

(require data/heap)

(define (max-events events)
  (define num-events (length events))

  ;; Handle empty input case
  (when (zero? num-events)
    (set! events '()) ; Ensure events is a list, even if empty
    0)

  ;; Sort events by start day, then by end day
  (define sorted-events (sort events (lambda (e1 e2)
                                       (let ([s1 (car e1)] [e1-end (cadr e1)]
                                             [s2 (car e2)] [e2-end (cadr e2)])
                                         (or (< s1 s2)
                                             (and (= s1 s2) (< e1-end e2-end)))))))

  (define event-ptr 0) ; Index for sorted-events
  (define attended-count 0)
  (define current-day 1) ; Start from day 1, as per problem constraints (days are positive integers)

  (define available-events (make-heap <)) ; Min-heap of end-days

  ;; Loop while there are still events to process (event-ptr < num-events)
  ;; or events in the heap that can potentially be attended (not (heap-empty? available-events))
  (while (or (< event-ptr num-events) (not (heap-empty? available-events)))
    ;; 1. If no events are currently available in the heap,
    ;;    and there are still events to process,
    ;;    advance current-day to the start day of the next event.
    ;;    This skips days where no events are active.
    (when (and (heap-empty? available-events) (< event-ptr num-events))
      (set! current-day (car (list-ref sorted-events event-ptr))))

    ;; 2. Add all events that start on `current-day` to the heap.
    ;;    These are now "available" to be attended.
    (let loop-add ()
      (when (and (< event-ptr num-events)
                 (= (car (list-ref sorted-events event-ptr)) current-day))
        (heap-add! available-events (cadr (list-ref sorted-events event-ptr))) ; Add end-day
        (set! event-ptr (add1 event-ptr))
        (loop-add)))

    ;; 3. Remove events from heap whose end-day is before `current-day`.
    ;;    These events have expired and can no longer be attended.
    (let loop-remove-expired ()
      (when (and (not (heap-empty? available-events))
                 (< (heap-min available-events) current-day))
        (heap-remove-min! available-events)
        (loop-remove-expired)))

    ;; 4. If there are valid events in the heap, attend one.
    ;;    We pick the one that ends earliest to maximize future opportunities.
    (when (not (heap-empty? available-events))
      (heap-remove-min! available-events) ; Attend this event (remove its end-day from heap)
      (set! attended-count (add1 attended-count))
      (set! current-day (add1 current-day))) ; Move to the next day
    ) ; End of while loop

  attended-count)