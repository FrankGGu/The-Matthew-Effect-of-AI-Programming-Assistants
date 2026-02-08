#lang racket

(require data/queue)
(require data/red-black-tree)

(define (minimum-reverse-operations n p k)
  (define ans (make-vector n -1))
  (define is-blocked (make-vector n #f))

  (for-each (lambda (idx) (vector-set! is-blocked idx #t)) p)

  (define q (make-queue))

  (define unvisited-even-rbt (rbt))
  (define unvisited-odd-rbt (rbt))

  (for ([i (in-range n)])
    (unless (vector-ref is-blocked i)
      (if (even? i)
          (set! unvisited-even-rbt (rbt-insert unvisited-even-rbt i i))
          (set! unvisited-odd-rbt (rbt-insert unvisited-odd-rbt i i)))))

  (vector-set! ans 0 0)
  (enqueue! q 0)
  (set! unvisited-even-rbt (rbt-remove unvisited-even-rbt 0))

  (define (process-range current-rbt L R current-dist)
    (let loop ((rbt current-rbt))
      (define lookup-result (rbt-find-next rbt L))
      (cond
        [(not lookup-result) rbt]
        [(> (car lookup-result) R) rbt]
        [else
         (define j (car lookup-result))
         (vector-set! ans j (+ current-dist 1))
         (enqueue! q j)
         (loop (rbt-remove rbt j))])))

  (let loop-bfs ()
    (unless (queue-empty? q)
      (define curr-idx (dequeue! q))
      (define current-dist (vector-ref ans curr-idx))

      (define min-s (max 0 (- curr-idx k -1)))
      (define max-s (min (- n k) curr-idx))

      (define L (+ (* 2 min-s) k -1 (- curr-idx)))
      (define R (+ (* 2 max-s) k -1 (- curr-idx)))

      (if (even? L)
          (set! unvisited-even-rbt (process-range unvisited-even-rbt L R current-dist))
          (set! unvisited-odd-rbt (process-range unvisited-odd-rbt L R current-dist)))

      (loop-bfs)))

  ans)