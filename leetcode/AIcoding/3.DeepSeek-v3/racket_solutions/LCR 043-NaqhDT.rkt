(define-struct node (left right val) #:mutable #:transparent)

(define (make-cbt-insert root)
  (let ([queue (make-queue)])
    (enqueue! queue root)
    (let loop ()
      (let ([current (front queue)])
        (cond
          [(not (node-left current))
           (set-node-left! current (make-node #f #f 0))
           (dequeue! queue)
           (enqueue! queue (node-left current))]
          [(not (node-right current))
           (set-node-right! current (make-node #f #f 0))
           (dequeue! queue)
           (enqueue! queue (node-right current))]
          [else
           (dequeue! queue)
           (enqueue! queue (node-left current))
           (enqueue! queue (node-right current))
           (loop)])))))

(define (CBTInserter-new root)
  (let ([queue (make-queue)])
    (enqueue! queue root)
    (let loop ()
      (let ([current (front queue)])
        (cond
          [(not (node-left current)) (make-cbt-insert root)]
          [(not (node-right current)) (make-cbt-insert root)]
          [else
           (dequeue! queue)
           (enqueue! queue (node-left current))
           (enqueue! queue (node-right current))
           (loop)])))
    (vector root queue)))

(define (CBTInserter-insert this v)
  (let ([root (vector-ref this 0)]
        [queue (vector-ref this 1)])
    (let ([parent (front queue)])
      (cond
        [(not (node-left parent))
         (set-node-left! parent (make-node #f #f v))
         (node-val parent)]
        [(not (node-right parent))
         (set-node-right! parent (make-node #f #f v))
         (dequeue! queue)
         (enqueue! queue (node-left parent))
         (enqueue! queue (node-right parent))
         (node-val parent)]))))

(define (CBTInserter-get_root this)
  (vector-ref this 0))

(define (make-queue) (mcons null null))

(define (enqueue! q x)
  (if (null? (mcar q))
      (begin
        (set-mcar! q (mcons x null))
        (set-mcdr! q (mcar q)))
      (begin
        (set-mcdr! (mcdr q) (mcons x null))
        (set-mcdr! q (mcdr (mcdr q))))))

(define (dequeue! q)
  (let ([front (mcar (mcar q))])
    (set-mcar! q (mcdr (mcar q)))
    (when (null? (mcar q))
      (set-mcdr! q null))
    front))

(define (front q)
  (mcar (mcar q)))