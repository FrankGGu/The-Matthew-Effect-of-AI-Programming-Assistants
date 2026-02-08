(define MOD 1000000007)

(define (power base exp)
  (let loop ([b base] [e exp] [res 1])
    (cond
      [(= e 0) res]
      [(= (remainder e 2) 1) (loop (remainder (* b b) MOD) (quotient e 2) (remainder (* res b) MOD))]
      [else (loop (remainder (* b b) MOD) (quotient e 2) res)])))

(define (mod-inverse n)
  (power n (- MOD 2)))

(define fact (make-vector 100001))
(define inv-fact (make-vector 100001))

(vector-set! fact 0 1)
(vector-set! inv-fact 0 1)
(for ([i (in-range 1 100001)])
  (vector-set! fact i (remainder (* (vector-ref fact (- i 1)) i) MOD))
  (vector-set! inv-fact i (mod-inverse (vector-ref fact i))))

(define (nCr n r)
  (cond
    [(< r 0) 0]
    [(> r n) 0]
    [else
     (remainder
      (* (vector-ref fact n)
         (vector-ref inv-fact r)
         (vector-ref inv-fact (- n r)))
      MOD)]))

(define (solve n nextRoom)
  (define adj-dep (make-vector n '())) ; Adjacency list for dependency tree
  (define chain-head (make-vector n 0)) ; Stores head of chain for each node
  (define chain-len (make-vector n 0))   ; Stores length for each chain head
  (define is-chain-head (make-vector n #f))
  (define is-pointed-to (make-vector n #f)) ; True if node is a successor in some chain

  ; Build adj-dep (dependency tree: p -> j if nextRoom[p] == j)
  ; And identify nodes that are successors in chains (not chain heads)
  (for ([i (in-range n)])
    (let ([nr (vector-ref nextRoom i)])
      (when (!= nr -1)
        (vector-set! adj-dep i (cons nr (vector-ref adj-dep i)))
        (vector-set! is-pointed-to nr #t))))

  ; Identify chains and their properties
  (for ([i (in-range n)])
    (when (not (vector-ref is-pointed-to i)) ; If i is not pointed to, it's a chain head
      (vector-set! is-chain-head i #t)
      (let loop-head-assign ([curr i])
        (when (!= curr -1)
          (vector-set! chain-head curr i)
          (loop-head-assign (vector-ref nextRoom curr))))
      (let loop-len ([curr i] [len 0])
        (if (!= curr -1)
            (loop-len (vector-ref nextRoom curr) (+ len 1))
            (vector-set! chain-len i len)))))

  (define memo (make-vector n #f)) ; Memoization table for DFS results (cons ways total-rooms)

  (letrec ([dfs-impl (lambda (u)
                       (let ([cached-result (vector-ref memo u)])
                         (if (not (eq? cached-result #f)) ; Check if already computed
                             cached-result
                             (begin
                               (let ([current-ways 1]
                                     [current-total-rooms (vector-ref chain-len u)])

                                 ; Find tail of chain u
                                 (let loop-tail ([curr u])
                                   (let ([next-node (vector-ref nextRoom curr)])
                                     (if (and (!= next-node -1) (= (vector-ref chain-head next-node) u))
                                         (loop-tail next-node)
                                         (let ([tail-u curr])
                                           ; Iterate over children in dependency tree from tail_u
                                           (for ([v (in-list (vector-ref adj-dep tail-u))])
                                             (let ([head-v (vector-ref chain-head v)])
                                               (when (!= head-v u) ; If v is head of a different chain
                                                 (let ([res-v (dfs-impl head-v)]) ; Recursive call
                                                   (let ([child-ways (car res-v)]
                                                         [child-total-rooms (cdr res-v)])
                                                     (set! current-ways (remainder (* current-ways child-ways) MOD))
                                                     (set! current-ways (remainder (* current-ways (nCr (+ current-total-rooms child-total-rooms) child-total-rooms)) MOD))
                                                     (set! current-total-rooms (+ current-total-rooms child-total-rooms))))))))))
                                 (vector-set! memo u (cons current-ways current-total-rooms))
                                 (cons current-ways current-total-rooms))))])

    (car (dfs-impl 0)))) ; The final answer is the number of ways for the subtree rooted at chain 0