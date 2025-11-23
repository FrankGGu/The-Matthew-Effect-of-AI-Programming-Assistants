(define (get-kth-node root k)
  (define (helper node count)
    (cond
      [(null? node) (values null count)]
      [else
       (define-values (left-node left-count) (helper (car node) count))
       (if (not (null? left-node))
           (values left-node left-count)
           (if (= (+ left-count 1) k)
               (values node (+ left-count 1))
               (helper (cdr node) (+ left-count 1))))]))
  (car (helper root 0)))

(define (replace-subtree root l r color)
  (define (helper node)
    (cond
      [(null? node) null]
      [else
       (cond
         [(= (car node) l)
          (cond
            [(= (car node) r)
             (list color null null)]
            [else
             (list color null (helper (cdr node)))])]
         [(< (car node) l)
          (list (car node) null (helper (cdr node)))]
         [(= (car node) r)
          (list color (helper (car node)) null)]
         [(> (car node) r)
          (list (car node) (helper (car node)) null)]
         [else
          (list color (helper (car node)) (helper (cdr node)))])]))
  (helper root))

(define (replace-node root node color)
  (define (helper n)
    (cond
      [(null? n) null]
      [else
       (cond
         [(= (car n) (car node)) (list color null null)]
         [(< (car n) (car node)) (list (car n) null (helper (cdr n)))]
         [else (list (car n) (helper (car n)) null)])]))
  (helper root))

(define (get-kth-node-value root k)
  (car (get-kth-node root k)))

(define (replace-range root l r color)
  (define (helper node)
    (cond
      [(null? node) null]
      [(< (car node) l) (list (car node) null (helper (cdr node)))]
      [(> (car node) r) (list (car node) (helper (car node)) null)]
      [else (list color (helper (car node)) (helper (cdr node)))])
    )
  (helper root))

(define (bstToArr root)
  (define (helper node acc)
    (cond
      [(null? node) acc]
      [else
       (helper (cdr node) (cons (car node) (helper (car node) acc)))]))
  (reverse (helper root '())))

(define (replace-range-optimized root l r color)
  (define (helper node)
    (cond
      [(null? node) null]
      [(< (car node) l) (list (car node) (car node) (helper (cdr node)))]
      [(> (car node) r) (list (car node) (helper (car node)) (cdr node))]
      [(and (>= (car node) l) (<= (car node) r)) (list color (helper (car node)) (helper (cdr node)))]
      [else node]))
  (helper root))

(define (replace-subtree-optimized root l r color)
  (define (helper node)
    (cond
      [(null? node) null]
      [else
       (cond
         [(< (car node) l) (list (car node) null (helper (cdr node)))]
         [(> (car node) r) (list (car node) (helper (car node)) null)]
         [else (list color (helper (car node)) (helper (cdr node)))])]))
  (helper root))