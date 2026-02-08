(define (maximum-sum-of-edge-values n edges values)
  (let* ([adj (make-vector n '())]
         [max-bit 20] ; Values are less than 2^20, so bits 0 to 19
         [total-max-sum 0])

    ;; Build adjacency list
    (for-each (lambda (edge)
                (let ([u (car edge)]
                      [v (cadr edge)])
                  (vector-set! adj u (cons v (vector-ref adj u)))
                  (vector-set! adj v (cons u (vector-ref adj v)))))
              edges)

    ;; Iterate over each bit position
    (for ([b (in-range max-bit)])
      (letrec ([dfs (lambda (u parent)
                      ;; dp-u-0: max sum of b-th bits in subtree of u if u's b-th bit is 0
                      ;; dp-u-1: max sum of b-th bits in subtree of u if u's b-th bit is 1
                      (let ([dp-u-0 0]
                            [dp-u-1 0])
                        (for-each (lambda (v)
                                    (when (not (= v parent))
                                      (let ([dp-v (dfs v u)])
                                        ;; If u's b-th bit is 0:
                                        ;;   - If v's b-th bit is 0, edge (u,v) contributes 0. Subtree v contributes (car dp-v).
                                        ;;   - If v's b-th bit is 1, edge (u,v) contributes 1. Subtree v contributes (cdr dp-v).
                                        ;; We choose the one that maximizes: max((car dp-v), (+ (cdr dp-v) 1))
                                        (set! dp-u-0 (+ dp-u-0 (max (car dp-v) (+ (cdr dp-v) 1))))

                                        ;; If u's b-th bit is 1:
                                        ;;   - If v's b-th bit is 0, edge (u,v) contributes 1. Subtree v contributes (car dp-v).
                                        ;;   - If v's b-th bit is 1, edge (u,v) contributes 0. Subtree v contributes (cdr dp-v).
                                        ;; We choose the one that maximizes: max((+ (car dp-v) 1), (cdr dp-v))
                                        (set! dp-u-1 (+ dp-u-1 (max (+ (car dp-v) 1) (cdr dp-v)))))))
                                  (vector-ref adj u))
                        (cons dp-u-0 dp-u-1)))])

        ;; Perform DFS from node 0 (arbitrary root) with parent -1
        (let ([root-dp (dfs 0 -1)])
          ;; Add the maximum possible sum for the current bit position, scaled by 2^b
          (set! total-max-sum (+ total-max-sum (* (max (car root-dp) (cdr root-dp)) (expt 2 b)))))))

    total-max-sum))