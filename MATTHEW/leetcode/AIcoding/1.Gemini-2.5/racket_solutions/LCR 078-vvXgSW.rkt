#lang racket

(require data/heap)

(struct list-node (val next) #:transparent)

(define (list-node<? a b)
  (< (list-node-val a) (list-node-val b)))

(define (merge-k-lists lists)
  (define min-heap (make-heap list-node<?))

  (for-each
   (lambda (node)
     (when node (heap-add! min-heap node)))
   lists)

  (define (build-result-list)
    (if (heap-empty? min-heap)
        #f
        (let* ([smallest-node (heap-min-pop! min-heap)]
               [next-node-in-original-list (list-node-next smallest-node)])
          (when next-node-in-original-list
            (heap-add! min-heap next-node-in-original-list))
          (list-node (list-node-val smallest-node) (build-result-list)))))

  (build-result-list))