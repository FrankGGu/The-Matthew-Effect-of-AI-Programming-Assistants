(define (num-components head G)
  (define g-set (set G))
  (define (helper node in-comp)
    (cond
      [(null? node) 0]
      [(set-member? g-set (node-value node))
       (if in-comp
         (helper (node-next node) #t)
         (+ 1 (helper (node-next node) #t))]
      [else (helper (node-next node) #f)]))
  (helper head #f))

(define (set lst)
  (foldr (lambda (x acc) (hash-set! acc x)) (hash) lst))

(define (set-member? s x)
  (hash-has-key? s x))

(define (node-value node)
  (if node (node-val node)))

(define (node-next node)
  (if node (node-next node)))