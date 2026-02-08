(define-struct segtree (left right l r sum) #:mutable #:transparent)

(define (build l r nums)
  (if (= l r)
      (make-segtree #f #f l r (vector-ref nums l))
      (let* ([mid (quotient (+ l r) 2)]
             [left (build l mid nums)]
             [right (build (+ mid 1) r nums)])
        (make-segtree left right l r (+ (segtree-sum left) (segtree-sum right))))))

(define (update-node node index val)
  (if (and (= (segtree-l node) index) (= (segtree-r node) index))
      (set-segtree-sum! node val)
      (let ([mid (quotient (+ (segtree-l node) (segtree-r node)) 2)])
        (if (<= index mid)
            (update-node (segtree-left node) index val)
            (update-node (segtree-right node) index val))
        (set-segtree-sum! node (+ (segtree-sum (segtree-left node)) 
                                   (segtree-sum (segtree-right node))))))

(define (query-range node l r)
  (if (and (<= l (segtree-l node)) (>= r (segtree-r node)))
      (segtree-sum node)
      (let ([mid (quotient (+ (segtree-l node) (segtree-r node)) 2)])
        (cond [(> l mid) (query-range (segtree-right node) l r)]
              [(< r (+ mid 1)) (query-range (segtree-left node) l r)]
              [else (+ (query-range (segtree-left node) l mid)
                       (query-range (segtree-right node) (+ mid 1) r))])))

(define num-array%
  (class object%
    (super-new)
    (init-field nums)
    (define root (build 0 (- (vector-length nums) 1) nums))

    (define/public (update index val)
      (update-node root index val))

    (define/public (sum-range left right)
      (query-range root left right))))