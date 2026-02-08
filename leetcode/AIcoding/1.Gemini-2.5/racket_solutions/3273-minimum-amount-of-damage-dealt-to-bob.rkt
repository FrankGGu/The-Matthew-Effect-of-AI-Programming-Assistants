#lang racket

(require data/heap) ; For priority queue

(define (minimum-amount-of-damage-dealt-to-bob damage bobHealth)
  (define N (vector-length damage))

  ;; min-total-damage[last_idx][h_rem] stores the minimum total damage dealt
  ;; to reduce Bob's health to h_rem, with last_idx being the most recently chosen attack.
  ;; Initialize with +inf.0 (positive infinity).
  (define min-total-damage
    (make-vector N (make-vector (add1 bobHealth) +inf.0)))

  ;; Priority queue: (total_damage, current_health_remaining, last_chosen_idx)
  ;; Ordered by total_damage (min-heap)
  (define pq (make-heap (lambda (a b) (< (car a) (car b)))))

  ;; Initialize the priority queue with all possible first attacks
  (for ([i (in-range N)])
    (define d_val (vector-ref damage i))
    (define h_after_attack (- bobHealth d_val))
    (define actual_h_rem (max 0 h_after_attack))

    ;; If this initial attack is better than any previously recorded path to this state
    (when (< d_val (vector-ref (vector-ref min-total-damage i) actual_h_rem))
      (vector-set! (vector-ref min-total-damage i) actual_h_rem d_val)
      (heap-add! pq (list d_val actual_h_rem i))))

  ;; Initialize minimum answer to infinity
  (define min-ans +inf.0)

  ;; Dijkstra's algorithm
  (while (not (heap-empty? pq))
    (define-values (td h_rem last_idx) (apply values (heap-min-pop! pq)))

    ;; If we already found a better path to this state, skip
    (when (> td (vector-ref (vector-ref min-total-damage last_idx) h_rem))
      (void)) ; continue to next iteration

    ;; If Bob's health is <= 0, update the global minimum answer
    (when (zero? h_rem)
      (set! min-ans (min min-ans td)))

    ;; Explore next possible attacks from the current state
    (for ([next_idx (in-range N)])
      ;; Check adjacency constraint: next_idx cannot be last_idx - 1 or last_idx + 1
      (unless (or (= next_idx (sub1 last_idx)) (= next_idx (add1 last_idx)))
        (define next_d_val (vector-ref damage next_idx))
        (define new_td (+ td next_d_val))
        (define new_h_rem (max 0 (- h_rem next_d_val)))

        ;; If this new path is better than any previously recorded path to the new state
        (when (< new_td (vector-ref (vector-ref min-total-damage next_idx) new_h_rem))
          (vector-set! (vector-ref min-total-damage next_idx) new_h_rem new_td)
          (heap-add! pq (list new_td new_h_rem next_idx))))))

  min-ans)