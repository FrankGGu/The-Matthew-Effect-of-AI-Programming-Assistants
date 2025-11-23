#lang racket

(require racket/queue)

(define (minimum-operations-to-make-x-and-y-equal x y)
  (when (= x y)
    0)

  (define q (make-queue))
  (define visited (make-hash))

  (queue-add! q (list x 0)) ; (current-value, operations)
  (hash-set! visited x 0)

  (let bfs-loop ()
    (let* ((current-state (queue-remove! q))
           (current-val (car current-state))
           (ops (cadr current-state)))

      ;; Check if target reached
      (when (= current-val y)
        ops) ; Return the operations count

      ;; Operation 1: x = x / 11
      (when (zero? (remainder current-val 11))
        (let* ((next-val (/ current-val 11))
               (next-ops (+ ops 1)))
          (when (or (not (hash-has-key? visited next-val))
                    (< next-ops (hash-ref visited next-val)))
            (hash-set! visited next-val next-ops)
            (queue-add! q (list next-val next-ops)))))

      ;; Operation 2: x = x / 5
      (when (zero? (remainder current-val 5))
        (let* ((next-val (/ current-val 5))
               (next-ops (+ ops 1)))
          (when (or (not (hash-has-key? visited next-val))
                    (< next-ops (hash-ref visited next-val)))
            (hash-set! visited next-val next-ops)
            (queue-add! q (list next-val next-ops)))))

      ;; Operation 3: x = x - 1
      (let* ((next-val (- current-val 1))
             (next-ops (+ ops 1)))
        (when (>= next-val 0) ; Ensure non-negative
          (when (or (not (hash-has-key? visited next-val))
                    (< next-ops (hash-ref visited next-val)))
            (hash-set! visited next-val next-ops)
            (queue-add! q (list next-val next-ops)))))

      ;; Operation 4: x = x + 1
      (let* ((next-val (+ current-val 1))
             (next-ops (+ ops 1)))
        ;; No explicit upper bound on next-val.
        ;; The hash table will implicitly prune redundant paths,
        ;; and the problem constraints usually ensure the number of visited states is manageable.
        (when (or (not (hash-has-key? visited next-val))
                  (< next-ops (hash-ref visited next-val)))
          (hash-set! visited next-val next-ops)
          (queue-add! q (list next-val next-ops))))

      (bfs-loop))) ; Continue BFS

  (bfs-loop))