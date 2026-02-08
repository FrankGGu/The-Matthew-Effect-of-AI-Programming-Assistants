(define throne-inheritance
  (lambda ()
    (define king 'King)
    (define family (make-hash))
    (define (birth child parent)
      (hash-set! family child (list parent))
      (hash-update! family parent (lambda (children) (cons child children)) '()))

    (define (death person)
      (hash-set! family person '()))

    (define (get-inheritance-order)
      (define (dfs person visited)
        (when (not (member person visited))
          (set! visited (cons person visited))
          (define children (hash-ref family person '()))
          (for-each (lambda (child) (dfs child visited)) children))
        visited)
      (define order (dfs king '()))
      (filter (lambda (x) (not (null? (hash-ref family x '())))) order))

    (define (get-inheritance-order)
      (define order (dfs king '()))
      (filter (lambda (x) (not (null? (hash-ref family x '())))) order))

    (lambda (operation . args)
      (cond
        ((equal? operation 'birth) (apply birth args))
        ((equal? operation 'death) (apply death args))
        ((equal? operation 'getInheritanceOrder) (get-inheritance-order))))))

(define throne (throne-inheritance))
(throne 'birth 'Charles 'King)
(throne 'birth 'John 'Charles)
(throne 'birth 'Richard 'Charles)
(throne 'death 'John)
(throne 'getInheritanceOrder)