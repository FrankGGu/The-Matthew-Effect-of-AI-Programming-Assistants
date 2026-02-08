#lang racket

(define (finding-users-active-minutes logs k)
  (define user-minutes-map (make-hash 'equal))

  (for-each (lambda (log)
              (define user-id (car log))
              (define minute (cadr log))
              (hash-set! user-minutes-map
                         user-id
                         (set-add (hash-ref user-minutes-map user-id (set))
                                  minute)))
            logs)

  (define uam-counts (make-vector k 0))

  (for-each (lambda (minute-set)
              (define uam (set-count minute-set))
              (when (and (>= uam 1) (<= uam k))
                (vector-set! uam-counts
                             (- uam 1)
                             (+ (vector-ref uam-counts (- uam 1)) 1))))
            (hash-values user-minutes-map))

  (vector->list uam-counts))