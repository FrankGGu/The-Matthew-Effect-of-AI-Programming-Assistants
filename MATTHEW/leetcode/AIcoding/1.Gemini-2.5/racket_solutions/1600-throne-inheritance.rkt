#lang racket

(struct throne-inheritance (children dead-set king-name) #:mutable)

(define (throne-inheritance-new king-name)
  (let ([children-map (make-hash)]
        [dead-set (make-set)])
    (hash-set! children-map king-name '()) ; Initialize king with no children
    (throne-inheritance children-map dead-set king-name)))

(define (throne-inheritance-birth this parent-name child-name)
  (let* ([children-map (throne-inheritance-children this)]
         [current-children (hash-ref children-map parent-name '())])
    (hash-set! children-map parent-name (append current-children (list child-name)))))

(define (throne-inheritance-death this name)
  (set-add! (throne-inheritance-dead-set this) name))

(define (throne-inheritance-get-inheritance-order this)
  (let* ([king (throne-inheritance-king-name this)]
         [children-map (throne-inheritance-children this)]
         [dead-set (throne-inheritance-dead-set this)])

    (define (dfs current-person acc)
      (let ([current-acc (if (not (set-member? dead-set current-person))
                             (cons current-person acc)
                             acc)])
        (foldr (lambda (child child-acc)
                 (dfs child child-acc))
               current-acc
               (hash-ref children-map current-person '()))))

    (reverse (dfs king '()))))