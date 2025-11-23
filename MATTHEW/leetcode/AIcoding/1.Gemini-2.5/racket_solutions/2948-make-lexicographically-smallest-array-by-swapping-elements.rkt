(define (make-dsu n)
  (define parent (make-vector n))
  (define rank (make-vector n 0))

  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find i)
    (if (= (vector-ref parent i) i)
        i
        (let ([root (find (vector-ref parent i))])
          (vector-set! parent i root)
          root)))

  (define (union i j)
    (let ([root-i (find i)]
          [root-j (find j)])
      (unless (= root-i root-j)
        (let ([rank-i (vector-ref rank root-i)]
              [rank-j (vector-ref rank root-j)])
          (cond
            [(> rank-i rank-j) (vector-set! parent root-j root-i)]
            [(< rank-i rank-j) (vector-set! parent root-i root-j)]
            [else
             (vector-set! parent root-j root-i)
             (vector-set! rank root-i (+ rank-i 1))]))
        #t)))

  (list find union))

(define (make-lexicographically-smallest-array nums limit)
  (define n (length nums))

  (define indexed-nums-list
    (for/list ([i (in-range n)])
      (list (list-ref nums i) i)))

  (define sorted-indexed-nums-list (sort indexed-nums-list (lambda (a b) (< (car a) (car b)))))
  (define sorted-indexed-nums (list->vector sorted-indexed-nums-list))

  (define-values (find union) (make-dsu n))

  (define head 0)
  (for ([j (in-range n)])
    (define current-pair (vector-ref sorted-indexed-nums j))
    (define current-val (car current-pair))
    (define current-original-idx (cadr current-pair))

    (let loop ()
      (when (< head j)
        (define head-pair (vector-ref sorted-indexed-nums head))
        (define head-val (car head-pair))
        (when (> (- current-val head-val) limit)
          (set! head (+ head 1))
          (loop))))

    (when (< head j)
      (define head-pair (vector-ref sorted-indexed-nums head))
      (define head-original-idx (cadr head-pair))
      (union current-original-idx head-original-idx)))

  (define component-values (make-hash))
  (define component-indices (make-hash))

  (for ([i (in-range n)])
    (define root (find i))
    (hash-update! component-values root (lambda (lst) (cons (list-ref nums i) lst)) '())
    (hash-update! component-indices root (lambda (lst) (cons i lst)) '()))

  (define result-vec (make-vector n))

  (for ([(root vals) (in-hash component-values)])
    (define sorted-vals (sort vals <))
    (define sorted-indices (sort (hash-ref component-indices root) <))

    (for ([k (in-range (length sorted-vals))])
      (vector-set! result-vec (list-ref sorted-indices k) (list-ref sorted-vals k))))

  (vector->list result-vec))