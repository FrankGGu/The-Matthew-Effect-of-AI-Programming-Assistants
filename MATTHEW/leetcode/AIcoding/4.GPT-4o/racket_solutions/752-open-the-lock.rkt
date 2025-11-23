#lang racket

(define (openLock deadends target)
  (define (next-states state)
    (for/fold ([states '()]) ([i (in-range 4)])
      (append states (list (list-set (list->vector state) i (mod (+ (vector-ref state i) 1) 10))
                           (list-set (list->vector state) i (mod (+ (vector-ref state i) 9) 10))))))

  (define (bfs)
    (define queue (list (list 0 "0000")))
    (define visited (make-hash))
    (hash-set! visited "0000" #t)
    (define deadset (set deadends))

    (let loop ()
      (if (null? queue)
          -1
          (let* ((current (car queue))
                 (depth (car current))
                 (state (cadr current))
                 (new-states (next-states (string->list state))))
            (for ([new-state new-states])
              (define new-state-str (list->string new-state))
              (unless (or (hash-has? visited new-state-str)
                          (set-member? deadset new-state-str))
                (if (equal? new-state-str target)
                    (return depth)
                    (begin
                      (hash-set! visited new-state-str #t)
                      (set! queue (append queue (list (list (+ depth 1) new-state-str))))))))
            (set! queue (cdr queue))
            (loop)))))

  (bfs))