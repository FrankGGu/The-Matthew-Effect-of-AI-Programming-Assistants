#lang racket

(require data/heap)
(require data/set)
(require racket/vector) ; For vector conversion

(struct person-wait (time index) #:transparent)

(struct bridge-event (finish-time direction person-index) #:transparent)

(define (person-wait-comparator a b)
  (or (< (person-wait-time a) (person-wait-time b))
      (and (= (person-wait-time a) (person-wait-time b))
           (< (person-wait-index a) (person-wait-index b)))))

(define (bridge-event-comparator a b)
  (< (bridge-event-finish-time a) (bridge-event-finish-time b)))

(define (time-to-cross-a-bridge n k times-list)
  (define current-time 0)

  ;; Convert times-list to a vector for O(1) access
  (define times (list->vector times-list))

  ;; Priority queues for people waiting
  (define left-bank-waiting-pq (make-heap person-wait-comparator))
  (define right-bank-waiting-to-cross-back-pq (make-heap person-wait-comparator))

  ;; Priority queue for bridges currently in use
  (define bridges-occupied-pq (make-heap bridge-event-comparator))

  ;; Sets to track current location of people
  (define on-left-bank (mutable-set))
  (define on-right-bank (mutable-set))

  ;; Initialize: all people on left bank, waiting to cross L->R
  (for ([i (in-range n)])
    (set-add! on-left-bank i)
    (set! left-bank-waiting-pq (heap-add left-bank-waiting-pq (person-wait (car (vector-ref times i)) i))))

  ;; Helper functions to get times for a person
  (define (get-l-to-r-time idx) (car (vector-ref times idx)))
  (define (get-r-to-l-time idx) (cadr (vector-ref times idx)))

  ;; Main simulation loop
  (let loop ()
    (when (< (set-count on-right-bank) n) ; Continue until all 'n' people are on the right bank
      ;; Step 1: Advance time if no immediate action is possible.
      ;; An immediate action is possible if there are available bridges AND
      ;; (people waiting on right to cross back OR people waiting on left to cross L->R).
      (define available-bridges-count (- k (heap-size bridges-occupied-pq)))
      (define can-immediately-assign-bridge
        (and (> available-bridges-count 0)
             (or (not (heap-empty? right-bank-waiting-to-cross-back-pq))
                 (not (heap-empty? left-bank-waiting-pq)))))

      ;; If no immediate assignment is possible and there are bridges in use,
      ;; advance current-time to the next bridge completion event.
      (when (and (not can-immediately-assign-bridge) (not (heap-empty? bridges-occupied-pq)))
        (set! current-time (max current-time (bridge-event-finish-time (heap-min bridges-occupied-pq)))))

      ;; Step 2: Process people finishing crossing at current-time
      (let loop-finish ()
        (when (and (not (heap-empty? bridges-occupied-pq))
                   (<= (bridge-event-finish-time (heap-min bridges-occupied-pq)) current-time))
          (let-values (((new-bridges-occupied-pq bridge-event-item) (heap-remove-min bridges-occupied-pq)))
            (set! bridges-occupied-pq new-bridges-occupied-pq)
            (let* ((direction (bridge-event-direction bridge-event-item))
                   (person-idx (bridge-event-person-index bridge-event-item)))

              (if (= direction 0) ; Person finished crossing L->R
                  (begin
                    (set-remove! on-left-bank person-idx)
                    (set-add! on-right-bank person-idx)
                    ;; If not all people are on the right bank yet, this person is available to cross back
                    (when (< (set-count on-right-bank) n)
                      (set! right-bank-waiting-to-cross-back-pq (heap-add right-bank-waiting-to-cross-back-pq (person-wait (get-r-to-l-time person-idx) person-idx)))))
                  (begin ; Person finished crossing R->L
                    (set-remove! on-right-bank person-idx)
                    (set-add! on-left-bank person-idx)
                    ;; This person is now back on the left, waiting to cross L->R again
                    (set! left-bank-waiting-pq (heap-add left-bank-waiting-pq (person-wait (get-l-to-r-time person-idx) person-idx)))))))
        (loop-finish))) ; Continue processing other finished bridges

      ;; Step 3: Assign people to available bridges
      (let loop-assign ()
        (define current-available-bridges (- k (heap-size bridges-occupied-pq)))
        (when (> current-available-bridges 0) ; If bridges are available
          (cond
            ((not (heap-empty? right-bank-waiting-to-cross-back-pq))
             ;; Rule: People on the right bank (crossing R->L) have priority
             (let-values (((new-pq person-wait-item) (heap-remove-min right-bank-waiting-to-cross-back-pq)))
               (set! right-bank-waiting-to-cross-back-pq new-pq)
               (let ((person-idx (person-wait-index person-wait-item)))
                 ;; Only assign if this person is still on the right bank and needs to cross back
                 (if (set-member? on-right-bank person-idx)
                     (begin
                       (set! bridges-occupied-pq (heap-add bridges-occupied-pq (bridge-event (+ current-time (get-r-to-l-time person-idx)) 1 person-idx)))
                       (loop-assign)) ; Try to assign another person if bridge available
                     (loop-assign))))) ; This person's status changed, try next person in PQ
            ((not (heap-empty? left-bank-waiting-pq))
             ;; Rule: People on the left bank (crossing L->R) next
             (let-values (((new-pq person-wait-item) (heap-remove-min left-bank-waiting-pq)))
               (set! left-bank-waiting-pq new-pq)
               (let ((person-idx (person-wait-index person-wait-item)))
                 ;; Only assign if this person is still on the left bank and needs to cross L->R
                 (if (set-member? on-left-bank person-idx)
                     (begin
                       (set! bridges-occupied-pq (heap-add bridges-occupied-pq (bridge-event (+ current-time (get-l-to-r-time person-idx)) 0 person-idx)))
                       (loop-assign)) ; Try to assign another person if bridge available
                     (loop-assign))))) ; This person's status changed, try next person in PQ
            (else
             ;; No one to assign to available bridges
             #f))))
    (loop))) ; Continue main simulation loop

  current-time)