#lang racket

(require data/queue)

(define (reachable-nodes n edges restricted)
  (define adj (make-hash))
  (for-each
   (lambda (edge)
     (define u (car edge))
     (define v (cadr edge))
     (hash-set! adj u (cons v (hash-ref adj u '())))
     (hash-set! adj v (cons u (hash-ref adj v '()))))
   edges)

  (define restricted-set (list->set restricted))

  (define q (make-queue))
  (queue-put! q 0)

  (define visited (set 0))
  (define count 1)

  (while (not (queue-empty? q))
    (define u (queue-get! q))

    (for-each
     (lambda (v)
       (unless (or (set-member? restricted-set v)
                   (set-member? visited v))
         (set! visited (set-add visited v))
         (set! count (+ count 1))
         (queue-put! q v)))
     (hash-ref adj u '())))

  count)