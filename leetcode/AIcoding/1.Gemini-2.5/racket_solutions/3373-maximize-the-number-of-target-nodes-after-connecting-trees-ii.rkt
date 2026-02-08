#lang racket

(define (make-queue)
  (list '() '())) ; (front-list back-list)

(define (queue-empty? q)
  (and (null? (car q)) (null? (cadr q))))

(define (queue-add! q item)
  (set-car! (cdr q) (cons item (cadr q)))) ; Add to back-list

(define (queue-take! q)
  (when (queue-empty? q) (error "queue-take!: queue is empty"))
  (when (null? (car q)) ; If front-list is empty, reverse back-list to front-list
    (set-car! q (reverse (cadr q)))
    (set-car! (cdr q) '()))
  (define item (car (car q)))
  (set-car! q (cdr (car q)))
  item)

(define (maximize-the-number-of-target-nodes-after-connecting-trees-ii n edges target start)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  (define is-target (make-vector n #f))
  (for-each (lambda (node) (vector-set! is-target node #t)) target)

  (define component-id (make-vector n -1))
  (define component-target-counts (make-vector n 0))
  (define current-component-id 0)

  (define (bfs-component start-node comp-id)
    (define q (make-queue))
    (queue-add! q start-node)
    (vector-set! component-id start-node comp-id)
    (define targets-in-comp 0)
    (when (vector-ref is-target start-node)
      (set! targets-in-comp (+ targets-in-comp 1)))

    (let loop ()
      (when (not (queue-empty? q))
        (define u (queue-take! q))
        (for-each (lambda (v)
                    (when (= (vector-ref component-id v) -1)
                      (vector-set! component-id v comp-id)
                      (when (vector-ref is-target v)
                        (set! targets-in-comp (+ targets-in-comp 1)))
                      (queue-add! q v)))
                  (vector-ref adj u))
        (loop)))
    targets-in-comp)

  (for ([i (in-range n)])
    (when (= (vector-ref component-id i) -1)
      (define targets (bfs-component i current-component-id))
      (vector-set! component-target-counts current-component-id targets)
      (set! current-component-id (+ current-component-id 1))))

  (define final-component-target-counts (subvector component-target-counts 0 current-component-id))

  (define start-comp-id (vector-ref component-id start))

  (define initial-reachable-targets (vector-ref final-component-target-counts start-comp-id))

  (define max-other-comp-targets 0)
  (for ([comp-idx (in-range current-component-id)])
    (when (not (= comp-idx start-comp-id))
      (set! max-other-comp-targets (max max-other-comp-targets (vector-ref final-component-target-counts comp-idx)))))

  (if (= current-component-id 1)
      initial-reachable-targets
      (+ initial-reachable-targets max-other-comp-targets)))

(define (solve n edges target start)
  (maximize-the-number-of-target-nodes-after-connecting-trees-ii n edges target start))