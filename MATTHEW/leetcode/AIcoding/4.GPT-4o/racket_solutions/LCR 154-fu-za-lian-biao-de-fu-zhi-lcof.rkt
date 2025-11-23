#lang racket

(define (copyRandomList head)
  (define (clone-node node)
    (if (null? node)
        null
        (let ([new-node (make-node (node-val node))])
          (set-node-random! new-node (node-random node))
          (set-node-next! new-node (clone-node (node-next node)))
          new-node)))

  (define (connect-random clone original)
    (when (and clone original)
      (set-node-random! clone (get-cloned-node (node-random original)))
      (connect-random (node-next clone) (node-next original))))

  (define (get-cloned-node original)
    (if (null? original) 
        null
        (let loop ([curr head])
          (cond
            [(null? curr) null]
            [(eq? (node-val curr) (node-val original)) curr]
            [else (loop (node-next curr))]))))

  (if (null? head)
      null
      (let ([cloned-head (clone-node head)])
        (connect-random cloned-head head)
        cloned-head)))

(define (make-node val)
  (define node (list val null null))
  (define (node-val) (car node))
  (define (node-next) (cadr node))
  (define (node-random) (caddr node))
  (define (set-node-next! next) (set-cadr! node next))
  (define (set-node-random! random) (set-caddr! node random))
  (define (set-node-val! value) (set-car! node value))
  (define-values (node-val node-next node-random set-node-next! set-node-random! set-node-val!) node)
  (values node-val node-next node-random set-node-next! set-node-random! set-node-val!))