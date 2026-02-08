(define (tree-of-coprimes parents nums)
  (define n (vector-length nums))
  (define adj-list (make-vector n '()))
  (for/list ([i (in-range 1 n)])
    (vector-set! adj-list (list-ref parents (- i 1)) (cons i (vector-ref adj-list (list-ref parents (- i 1)))))
    (vector-set! adj-list i (cons (list-ref parents (- i 1)) (vector-ref adj-list i))))

  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))

  (define result (make-vector n -1))

  (define (dfs node parent path-nums path-nodes)
    (define best-ancestor -1)
    (define min-depth +inf.0)
    (for ([i (in-range (length path-nums))])
      (when (= (gcd (list-ref path-nums i) (vector-ref nums node)) 1)
        (when (< i min-depth)
          (set! min-depth i)
          (set! best-ancestor (list-ref path-nodes i)))))
    (vector-set! result node best-ancestor)

    (define next-path-nums (cons (vector-ref nums node) path-nums))
    (define next-path-nodes (cons node path-nodes))

    (for ([neighbor (in-vector-ref adj-list node)])
      (when (not (= neighbor parent))
        (dfs neighbor node next-path-nums next-path-nodes))))

  (dfs 0 -1 '() '())
  result)