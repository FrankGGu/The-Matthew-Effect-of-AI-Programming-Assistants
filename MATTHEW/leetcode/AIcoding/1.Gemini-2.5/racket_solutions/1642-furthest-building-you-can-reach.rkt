#lang racket

(require racket/heap)

(define (furthest-building heights bricks ladders)
  (define n (vector-length heights))
  (define pq (make-heap <)) ; Min-priority queue to store jump heights where bricks were used

  (let loop ([i 0] [current-bricks bricks] [current-ladders ladders])
    (if (>= i (- n 1))
        ; Successfully reached or passed the last building (index n-1)
        (- n 1)
        (let* ([h1 (vector-ref heights i)]
               [h2 (vector-ref heights (+ i 1))]
               [diff (- h2 h1)])
          (if (> diff 0)
              ; A jump is required
              (begin
                (heap-add! pq diff) ; Add the jump height to the priority queue
                (let ([next-bricks (- current-bricks diff)])
                  (if (< next-bricks 0)
                      ; Not enough bricks for this jump
                      (if (> current-ladders 0)
                          ; Use a ladder for the largest jump made so far (which is the current smallest in PQ after adding current diff)
                          (begin
                            (let ([smallest-jump (heap-min pq)]) ; Get the smallest jump from PQ (which was covered by bricks)
                              (heap-remove-min! pq) ; Remove it
                              (loop (+ i 1)
                                    (+ next-bricks smallest-jump) ; Restore bricks by using ladder on smallest_jump
                                    (- current-ladders 1))))
                          ; No ladders left, cannot proceed
                          i)
                      ; Bricks are sufficient, continue to the next building
                      (loop (+ i 1) next-bricks current-ladders))))
              ; No jump required (heights[i+1] <= heights[i]), continue to the next building
              (loop (+ i 1) current-bricks current-ladders))))))