#lang racket

(require data/queue)
(require racket/control)

(define (nearest-exit maze entrance)
  (define rows (length maze))
  (define cols (string-length (car maze)))

  (define (get-char r c)
    (string-ref (list-ref maze r) c))

  (define (is-exit r c)
    (and (char=? (get-char r c) #\.)
         (or (= r 0) (= r (- rows 1))
             (= c 0) (= c (- cols 1)))))

  (define q (make-queue))
  (define visited (make-vector rows (make-vector cols #f)))

  (define start-r (list-ref entrance 0))
  (define start-c (list-ref entrance 1))

  (enqueue! q (list entrance 0))
  (vector-set! (vector-ref visited start-r) start-c #t)

  (define dr (list -1 1 0 0))
  (define dc (list 0 0 -1 1))

  (let/ec return-result
    (let bfs-loop ()
      (if (queue-empty? q)
          -1
          (let* ((current (dequeue! q))
                 (current-pos (list-ref current 0))
                 (r (list-ref current-pos 0))
                 (c (list-ref current-pos 1))
                 (steps (list-ref current 1)))

            (for ([i (range 4)])
              (define nr (+ r (list-ref dr i)))
              (define nc (+ c (list-ref dc i)))

              (when (and (>= nr 0) (< nr rows)
                         (>= nc 0) (< nc cols)
                         (char=? (get-char nr nc) #\.)
                         (not (vector-ref (vector-ref visited nr) nc)))

                (when (and (is-exit nr nc)
                           (not (and (= nr start-r) (= nc start-c))))
                  (return-result (+ steps 1)))

                (vector-set! (vector-ref visited nr) nc #t)
                (enqueue! q (list (list nr nc) (+ steps 1)))))
            (bfs-loop)))))
  )