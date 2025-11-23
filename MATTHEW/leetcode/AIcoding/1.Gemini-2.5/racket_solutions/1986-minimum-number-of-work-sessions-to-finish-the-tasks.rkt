#lang racket

(define (min-sessions tasks sessionTime)
  (define n (vector-length tasks))
  (define max-mask (arithmetic-shift 1 n))

  (define dp (make-vector max-mask (cons +inf.0 -inf.0)))

  (vector-set! dp 0 (cons 1 0))

  (for ([mask (in-range max-mask)])
    (define current-state (vector-ref dp mask))
    (define current-sessions (car current-state))
    (define current-load (cdr current-state))

    (when (< current-sessions +inf.0)
      (for ([i (in-range n)])
        (when (zero? (bitwise-and mask (arithmetic-shift 1 i)))
          (define next-mask (bitwise-ior mask (arithmetic-shift 1 i)))
          (define task-duration (vector-ref tasks i))

          (define next-sessions current-sessions)
          (define next-load current-load)

          (if (<= (+ current-load task-duration) sessionTime)
              (set! next-load (+ current-load task-duration))
              (begin
                (set! next-sessions (+ current-sessions 1))
                (set! next-load task-duration)))

          (define existing-next-state (vector-ref dp next-mask))
          (define existing-next-sessions (car existing-next-state))
          (define existing-next-load (cdr existing-next-state))

          (cond
            ((< next-sessions existing-next-sessions)
             (vector-set! dp next-mask (cons next-sessions next-load)))
            ((= next-sessions existing-next-sessions)
             (when (> next-load existing-next-load)
               (vector-set! dp next-mask (cons next-sessions next-load))))))))))

  (car (vector-ref dp (- max-mask 1))))