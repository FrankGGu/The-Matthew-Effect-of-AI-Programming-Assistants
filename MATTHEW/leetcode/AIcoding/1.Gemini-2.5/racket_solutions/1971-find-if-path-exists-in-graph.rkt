#lang racket

(require data/queue)
(require data/set)

(define (find-if-path-exists n edges source destination)
  (define graph (make-hash))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (hash-update! graph u (lambda (lst) (cons v lst)) '())
              (hash-update! graph v (lambda (lst) (cons u lst)) '()))
            edges)

  (define q (make-queue))
  (define visited (set))

  (queue-add! q source)
  (set-add! visited source)

  (let loop ()
    (if (queue-empty? q)
        #false
        (begin
          (define u (queue-remove! q))

          (when (= u destination)
            (true))

          (define neighbors (hash-ref graph u '()))
          (for-each (lambda (v)
                      (unless (set-member? visited v)
                        (set-add! visited v)
                        (queue-add! q v)))
                    neighbors)
          (loop))))
)