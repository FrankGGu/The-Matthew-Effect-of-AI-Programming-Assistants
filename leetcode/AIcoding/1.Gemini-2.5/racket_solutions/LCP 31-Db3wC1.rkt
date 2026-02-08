#lang racket

(require data/queue)
(require racket/control)

(define (shortest-path-transforming-maze maze)
  (define R (length maze))
  (define C (string-length (car maze)))

  (define start-pos (list -1 -1))
  (define end-pos (list -1 -1))

  (for ([r (in-range R)])
    (for ([c (in-range C)])
      (case (string-ref (list-ref maze r) c)
        [#\S (set! start-pos (list r c))]
        [#\E (set! end-pos (list r c))])))

  (define dr (list -1 1 0 0))
  (define dc (list 0 0 -1 1))

  (define q (make-queue))
  (queue-put! q (list (car start-pos) (cadr start-pos) 0))

  (define visited (make-hash))
  (hash-set! visited (list (car start-pos) (cadr start-pos) 0) #t)

  (define (is-blocked-at-time? r c t)
    (let ([cell-char (string-ref (list-ref maze r) c)])
      (cond
        [(char=? cell-char #\#) #t]
        [(char=? cell-char #\X) (= (modulo t 2) 0)]
        [else #f])))

  (let/ec return-from-bfs
    (let loop ()
      (if (queue-empty? q)
          (return-from-bfs -1)
          (let* ([current (queue-get! q)]
                 [r (list-ref current 0)]
                 [c (list-ref current 1)]
                 [t (list-ref current 2)])

            (when (and (= r (car end-pos)) (= c (cadr end-pos)))
              (return-from-bfs t))

            (for ([i (in-range 4)])
              (define nr (+ r (list-ref dr i)))
              (define nc (+ c (list-ref dc i)))
              (define nt (+ t 1))

              (when (and (>= nr 0) (< nr R)
                         (>= nc 0) (< nc C)
                         (not (is-blocked-at-time? nr nc nt)))
                (define next-state (list nr nc nt))
                (when (not (hash-has-key? visited next-state))
                  (hash-set! visited next-state #t)
                  (queue-put! q next-state))))
            (loop))))))