(define NeighborSumService
  (lambda ()
    (define neighbors (make-hash))
    (define (add-neighbor key value)
      (hash-update! neighbors key (lambda (v) (if v (cons value v) (list value))) '()))
    (define (remove-neighbor key value)
      (hash-update! neighbors key (lambda (v) (filter (lambda (x) (not (= x value))) v)) '()))
    (define (sum-neighbors key)
      (if (hash-has-key? neighbors key)
          (apply + (hash-ref neighbors key))
          0))
    (define (add key value)
      (add-neighbor key value)
      (add-neighbor value key))
    (define (remove key value)
      (remove-neighbor key value)
      (remove-neighbor value key))
    (define (get-sum key)
      (sum-neighbors key))
    (define (get-neighbors)
      neighbors)
    (lambda (cmd . args)
      (case cmd
        [(add) (apply add args)]
        [(remove) (apply remove args)]
        [(get-sum) (apply get-sum args)]
        [(get-neighbors) (get-neighbors)]))))

(define obj (NeighborSumService))
(obj 'add 1 2)
(obj 'add 2 3)
(obj 'get-sum 2) ; should return 4
(obj 'remove 2 3)
(obj 'get-sum 2) ; should return 1