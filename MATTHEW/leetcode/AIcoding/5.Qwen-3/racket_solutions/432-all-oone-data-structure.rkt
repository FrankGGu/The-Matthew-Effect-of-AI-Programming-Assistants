#lang racket

(define-struct node (count keys) #:mutable)

(define (make-all-one)
  (let ([head (make-node 0 '())]
        [tail (make-node 0 '())])
    (set-node-next! head tail)
    (set-node-prev! tail head)
    (define (get-node-count node) (node-count node))
    (define (get-node-keys node) (node-keys node))
    (define (set-node-keys! node keys) (set-node-keys! node keys))
    (define (get-node-prev node) (node-prev node))
    (define (get-node-next node) (node-next node))
    (define (set-node-prev! node prev) (set-node-prev! node prev))
    (define (set-node-next! node next) (set-node-next! node next))
    (define (create-node count keys)
      (make-node count keys))
    (define (insert-after node new-node)
      (set-node-next! new-node (get-node-next node))
      (set-node-prev! new-node node)
      (set-node-prev! (get-node-next node) new-node)
      (set-node-next! node new-node))
    (define (remove-node node)
      (set-node-next! (get-node-prev node) (get-node-next node))
      (set-node-prev! (get-node-next node) (get-node-prev node)))
    (define (get-first-node) head)
    (define (get-last-node) tail)
    (define (get-node-for-count count)
      (let loop ([n (get-node-next head)])
        (cond [(eq? n tail) #f]
              [(= (get-node-count n) count) n]
              [else (loop (get-node-next n))])))
    (define (get-keys-for-count count)
      (if (eq? (get-node-count (get-node-for-count count)) count)
          (get-node-keys (get-node-for-count count))
          '()))
    (define (add-key key count)
      (let ([node (get-node-for-count count)])
        (if node
            (set-node-keys! node (cons key (get-node-keys node)))
            (begin
              (let ([new-node (create-node count (list key))])
                (insert-after (get-node-prev (get-node-for-count (- count 1))) new-node))))))
    (define (remove-key key count)
      (let ([node (get-node-for-count count)])
        (set-node-keys! node (remove key (get-node-keys node)))
        (when (null? (get-node-keys node))
          (remove-node node))))
    (define (inc key)
      (let ([current (get-node-for-count (get-count key))])
        (if current
            (begin
              (remove-key key (get-count key))
              (let ([next-count (+ (get-count key) 1)])
                (add-key key next-count)
                (set-count key next-count)))
            (begin
              (add-key key 1)
              (set-count key 1))))
      (void))
    (define (dec key)
      (let ([current (get-node-for-count (get-count key))])
        (if current
            (begin
              (remove-key key (get-count key))
              (let ([prev-count (- (get-count key) 1)])
                (if (> prev-count 0)
                    (begin
                      (add-key key prev-count)
                      (set-count key prev-count))
                    (set-count key 0))))
            (void)))
      (void))
    (define (get-max-key)
      (let loop ([n (get-node-prev tail)])
        (if (eq? n head)
            ""
            (let ([keys (get-node-keys n)])
              (if (null? keys)
                  (loop (get-node-prev n))
                  (car keys)))))
    (define (get-min-key)
      (let loop ([n (get-node-next head)])
        (if (eq? n tail)
            ""
            (let ([keys (get-node-keys n)])
              (if (null? keys)
                  (loop (get-node-next n))
                  (car keys)))))
    (define (get-count key)
      (hash-ref counts key 0))
    (define (set-count key count)
      (hash-set! counts key count))
    (define counts (make-hash))
    (lambda (op . args)
      (case op
        [(inc) (inc (car args))]
        [(dec) (dec (car args))]
        [(get-max-key) (get-max-key)]
        [(get-min-key) (get-min-key)]))))

(define all-one (make-all-one))

(define (main)
  (all-one 'inc "a")
  (all-one 'inc "a")
  (all-one 'inc "b")
  (all-one 'get-max-key)
  (all-one 'get-min-key))

(main)