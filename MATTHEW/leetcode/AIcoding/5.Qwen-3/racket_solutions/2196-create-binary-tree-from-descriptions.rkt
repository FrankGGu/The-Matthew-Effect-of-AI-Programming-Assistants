#lang racket

(define (create-binary-tree descriptions)
  (define node-map (make-hash))
  (define in-degree (make-hash))
  (for-each
   (lambda (desc)
     (let ((parent (car desc))
           (child (cadr desc))
           (is-left (caddr desc)))
       (when (not (hash-has-key? node-map parent))
         (hash-set! node-map parent (list parent #f #f)))
       (when (not (hash-has-key? node-map child))
         (hash-set! node-map child (list child #f #f)))
       (if is-left
           (begin
             (set-car! (list-ref (hash-ref node-map parent) 1) child)
             (hash-set! in-degree child (+ (hash-ref in-degree child 0) 1)))
           (begin
             (set-car! (list-ref (hash-ref node-map parent) 2) child)
             (hash-set! in-degree child (+ (hash-ref in-degree child 0) 1)))))
   descriptions)
  (let loop ()
    (let ((candidate (for/first ((k (in-hash-keys node-map)) #:when (= (hash-ref in-degree k 0) 0)) k))
          (found #f))
      (when candidate
        (set! found #t)
        (let ((node (hash-ref node-map candidate)))
          (let ((left (cadr node))
                (right (caddr node)))
            (when left
              (hash-set! in-degree left (- (hash-ref in-degree left 0) 1)))
            (when right
              (hash-set! in-degree right (- (hash-ref in-degree right 0) 1)))
            (loop))))
      (if found
          (hash-ref node-map candidate)
          (error "No root found")))))

(define (make-tree-node val left right)
  (list val left right))

(define (tree->list tree)
  (if (null? tree)
      '()
      (append (list (car tree))
              (tree->list (cadr tree))
              (tree->list (caddr tree))))

(define (main)
  (let ((descriptions '((2 1 #t) (2 3 #f) (3 4 #t))))
    (let ((root (create-binary-tree descriptions)))
      (display (tree->list root))
      (newline))))

(main)