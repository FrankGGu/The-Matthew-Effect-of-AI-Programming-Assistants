(define (maximum-k-divisible-components n edges nums k)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (let ((u (car edge))
                    (v (cadr edge)))
                (vector-set! adj u (cons v (vector-ref adj u)))
                (vector-set! adj v (cons u (vector-ref adj v)))))
            edges)

  (define component-count (box 0))

  (define (dfs u p)
    (define current-sum (list-ref nums u))

    (for-each (lambda (v)
                (when (not (= v p))
                  (set! current-sum (+ current-sum (dfs v u)))))
              (vector-ref adj u))

    (define sum-mod-k (modulo current-sum k))

    (if (= sum-mod-k 0)
        (begin
          (set-box! component-count (+ (unbox component-count) 1))
          0)
        sum-mod-k))

  (dfs 0 -1)

  (unbox component-count))