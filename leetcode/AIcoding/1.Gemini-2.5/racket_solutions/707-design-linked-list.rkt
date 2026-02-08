(define-struct (node #:mutable) (val next))

(define-struct (my-linked-list #:mutable) (head tail size))

(define (my-linked-list%)
  (let ([dummy-head (make-node 0 #f)])
    (make-my-linked-list dummy-head dummy-head 0)))

(define (get-node-at-index ll index)
  (cond
    [(or (< index 0) (>= index (my-linked-list-size ll)))
     (values #f #f)]
    [else
     (let loop ([current (node-next (my-linked-list-head ll))]
                [prev (my-linked-list-head ll)]
                [i 0])
       (if (= i index)
           (values current prev)
           (loop (node-next current) current (+ i 1))))]))

(define (my-linked-list-get ll index)
  (let-values (((node prev) (get-node-at-index ll index)))
    (if node
        (node-val node)
        -1)))

(define (my-linked-list-addAtHead ll val)
  (let ([new-node (make-node val (node-next (my-linked-list-head ll)))])
    (set-node-next! (my-linked-list-head ll) new-node)
    (when (= (my-linked-list-size ll) 0)
      (set-my-linked-list-tail! ll new-node))
    (set-my-linked-list-size! ll (+ (my-linked-list-size ll) 1))))

(define (my-linked-list-addAtTail ll val)
  (let ([new-node (make-node val #f)])
    (set-node-next! (my-linked-list-tail ll) new-node)
    (set-my-linked-list-tail! ll new-node)
    (set-my-linked-list-size! ll (+ (my-linked-list-size ll) 1))))

(define (my-linked-list-addAtIndex ll index val)
  (cond
    [(< index 0)
     (my-linked-list-addAtHead ll val)]
    [(> index (my-linked-list-size ll))
     #f]
    [else
     (if (= index (my-linked-list-size ll))
         (my-linked-list-addAtTail ll val)
         (let-values (((_ prev-node) (get-node-at-index ll index)))
           (let ([new-node (make-node val (node-next prev-node))])
             (set-node-next! prev-node new-node)
             (set-my-linked-list-size! ll (+ (my-linked-list-size ll) 1)))))]))

(define (my-linked-list-deleteAtIndex ll index)
  (when (and (>= index 0) (< index (my-linked-list-size ll)))
    (let-values (((node-to-delete prev-node) (get-node-at-index ll index)))
      (set-node-next! prev-node (node-next node-to-delete))
      (when (eq? node-to-delete (my-linked-list-tail ll))
        (set-my-linked-list-tail! ll prev-node))
      (set-my-linked-list-size! ll (- (my-linked-list-size ll) 1))
      (when (= (my-linked-list-size ll) 0)
        (set-my-linked-list-tail! ll (my-linked-list-head ll))))))