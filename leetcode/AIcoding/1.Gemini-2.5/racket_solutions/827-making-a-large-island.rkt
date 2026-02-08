#lang racket

(require racket/queue)

(define (largest-island grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  ;; Convert list of lists to vector of vectors for mutable access
  (define mutable-grid (list->vector (map list->vector grid)))

  (define island-id 2) ; Start island IDs from 2 (0 and 1 are grid values)
  (define island-sizes (make-hash)) ; Maps island-id -> size
  (define max-overall-size 0)

  ;; BFS helper to find and size an island
  (define (bfs start-r start-c current-island-id)
    (define q (make-queue))
    (queue-push! q (list start-r start-c))
    (vector-set! (vector-ref mutable-grid start-r) start-c current-island-id)
    (define current-size 0)

    (define drs '(-1 1 0 0))
    (define dcs '(0 0 -1 1))

    (let loop ()
      (when (not (queue-empty? q))
        (define current-pos (queue-pop! q))
        (define cur-r (car current-pos))
        (define cur-c (cadr current-pos))
        (set! current-size (+ current-size 1))

        (for ((i (range 4)))
          (define nr (+ cur-r (list-ref drs i)))
          (define nc (+ cur-c (list-ref dcs i)))

          (when (and (>= nr 0) (< nr rows)
                     (>= nc 0) (< nc cols)
                     (= (vector-ref (vector-ref mutable-grid nr) nc) 1))
            (vector-set! (vector-ref mutable-grid nr) nc current-island-id)
            (queue-push! q (list nr nc))))
        (loop)))
    current-size)

  ;; First Pass: Identify and size existing islands
  (for* ((r (range rows))
         (c (range cols)))
    (when (= (vector-ref (vector-ref mutable-grid r) c) 1)
      (define size (bfs r c island-id))
      (hash-set! island-sizes island-id size)
      (set! max-overall-size (max max-overall-size size))
      (set! island-id (+ island-id 1))))

  ;; Second Pass: Iterate through '0's and try flipping them
  (for* ((r (range rows))
         (c (range cols)))
    (when (= (vector-ref (vector-ref mutable-grid r) c) 0)
      (define current-potential-size 1) ; For the flipped '0' itself
      (define adjacent-island-ids (make-hash)) ; Use hash to store unique IDs

      (define drs '(-1 1 0 0))
      (define dcs '(0 0 -1 1))

      (for ((i (range 4)))
        (define nr (+ r (list-ref drs i)))
        (define nc (+ c (list-ref dcs i)))

        (when (and (>= nr 0) (< nr rows)
                   (>= nc 0) (< nc cols))
          (define neighbor-val (vector-ref (vector-ref mutable-grid nr) nc))
          ;; If neighbor is an island (ID > 1)
          (when (> neighbor-val 1)
            (hash-set! adjacent-island-ids neighbor-val #t)))) ; Value doesn't matter, just key presence

      (for-each (lambda (id)
                  (set! current-potential-size
                        (+ current-potential-size (hash-ref island-sizes id))))
                (hash-keys adjacent-island-ids))

      (set! max-overall-size (max max-overall-size current-potential-size))))

  ;; The max-overall-size variable correctly tracks the largest island size found.
  ;; If the grid was all '1's, max-overall-size would be (rows * cols) after the first pass.
  ;; If the grid was all '0's, max-overall-size would be 1 after the second pass.
  ;; Otherwise, it's the largest possible island found.
  max-overall-size)