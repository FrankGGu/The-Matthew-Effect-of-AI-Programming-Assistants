#lang racket

(define (maximum-score-from-grid-operations grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))

  ;; Node indexing:
  ;; S = 0
  ;; T = 1
  ;; N_rc nodes: 2 to m*n + 1
  ;; P_rc_xy nodes: m*n + 2 to m*n + 1 + Adj_count
  (define (coord->node-idx r c) (+ (* r n) c 2))

  (define adj-count 0)
  (for* ([r (in-range m)]
         [c (in-range n)])
    (when (< c (- n 1)) (set! adj-count (+ adj-count 1))) ; Horizontal
    (when (< r (- m 1)) (set! adj-count (+ adj-count 1)))) ; Vertical

  (define num-n-nodes (* m n))
  (define num-p-nodes adj-count)
  (define num-nodes (+ 2 num-n-nodes num-p-nodes))

  (define graph (make-vector num-nodes null))

  ;; Helper to add an edge (u v capacity) and its reverse edge
  (define (add-edge u v capacity)
    (define u-adj (vector-ref graph u))
    (define v-adj (vector-ref graph v))
    (define u-idx (length u-adj))
    (define v-idx (length v-adj))
    (vector-set! graph u (cons (list v capacity v-idx) u-adj))
    (vector-set! graph v (cons (list u 0 u-idx) v-adj))) ; Residual graph reverse edge has 0 initial capacity

  ;; Build graph
  (define total-initial-grid-sum 0)
  (define total-p-prime-positive-sum 0)

  (for* ([r (in-range m)]
         [c (in-range n)])
    (define val (vector-ref (vector-ref grid r) c))
    (set! total-initial-grid-sum (+ total-initial-grid-sum val))

    (define p-prime (- 1 val)) ; P'_rc = 1 - grid[r][c]
    (define n-node-idx (coord->node-idx r c))

    (if (> p-prime 0)
        (begin
          (add-edge 0 n-node-idx p-prime) ; S -> N_rc
          (set! total-p-prime-positive-sum (+ total-p-prime-positive-sum p-prime)))
        (add-edge n-node-idx 1 (abs p-prime)))) ; N_rc -> T

  (define p-node-counter 0)
  (for* ([r (in-range m)]
         [c (in-range n)])
    (define n-node-idx (coord->node-idx r c))
    ;; Horizontal adjacent pairs
    (when (< c (- n 1))
      (define next-n-node-idx (coord->node-idx r (+ c 1)))
      (define p-node-idx (+ 2 num-n-nodes p-node-counter))
      (set! p-node-counter (+ p-node-counter 1))
      (add-edge p-node-idx 1 1) ; P_rc_xy -> T with capacity 1
      (add-edge n-node-idx p-node-idx (expt 10 9)) ; N_rc -> P_rc_xy with infinite capacity
      (add-edge next-n-node-idx p-node-idx (expt 10 9))) ; N_xy -> P_rc_xy with infinite capacity

    ;; Vertical adjacent pairs
    (when (< r (- m 1))
      (define next-n-node-idx (coord->node-idx (+ r 1) c))
      (define p-node-idx (+ 2 num-n-nodes p-node-counter))
      (set! p-node-counter (+ p-node-counter 1))
      (add-edge p-node-idx 1 1) ; P_rc_xy -> T with capacity 1
      (add-edge n-node-idx p-node-idx (expt 10 9)) ; N_rc -> P_rc_xy with infinite capacity
      (add-edge next-n-node-idx p-node-idx (expt 10 9)))) ; N_xy -> P_rc_xy with infinite capacity

  ;; Dinic's algorithm
  (define level (make-vector num-nodes 0))
  (define ptr (make-vector num-nodes 0)) ; For DFS, to avoid re-exploring edges

  ;; BFS to build level graph
  (define (bfs)
    (vector-fill! level -1)
    (vector-set! level 0 0)
    (define q (make-queue))
    (queue-add! q 0)
    (let loop ()
      (when (not (queue-empty? q))
        (define u (queue-remove! q))
        (for-each (lambda (edge)
                    (define v (car edge))
                    (define capacity (cadr edge))
                    (when (and (> capacity 0) (= (vector-ref level v) -1))
                      (vector-set! level v (+ (vector-ref level u) 1))
                      (queue-add! q v)))
                  (vector-ref graph u))
        (loop))))

  ;; DFS to find augmenting path
  (define (dfs u pushed)
    (cond
      [(= pushed 0) 0]
      [(= u 1) pushed] ; Reached sink
      [else
       (let loop ([i (vector-ref ptr u)]
                  [current-adj (vector-ref graph u)])
         (cond
           [(>= i (length current-adj)) 0] ; No more edges from u
           [else
            (define edge (list-ref current-adj i))
            (define v (car edge))
            (define capacity (cadr edge))
            (define rev-idx (caddr edge))

            (vector-set! ptr u (+ (vector-ref ptr u) 1)) ; Move pointer

            (if (and (> capacity 0) (= (vector-ref level v) (+ (vector-ref level u) 1)))
                (let ([tr (dfs v (min pushed capacity))])
                  (if (> tr 0)
                      (begin
                        ;; Update capacities
                        (let* ([u-adj (vector-ref graph u)]
                               [v-adj (vector-ref graph v)]
                               [u-edge-old (list-ref u-adj i)]
                               [v-edge-old (list-ref v-adj rev-idx)]
                               [new-u-edge (list (car u-edge-old) (- (cadr u-edge-old) tr) (caddr u-edge-old))]
                               [new-v-edge (list (car v-edge-old) (+ (cadr v-edge-old) tr) (caddr v-edge-old))])
                          (vector-set! graph u (list-set u-adj i new-u-edge))
                          (vector-set! graph v (list-set v-adj rev-idx new-v-edge)))
                        tr)
                      (loop (+ i 1) current-adj))) ; Try next edge if this path didn't push flow
                (loop (+ i 1) current-adj)))]))])))

  ;; Max flow calculation
  (define (max-flow)
    (define flow 0)
    (let loop ()
      (bfs)
      (when (> (vector-ref level 1) -1) ; If T is reachable from S
        (vector-fill! ptr 0)
        (let ([pushed (dfs 0 (expt 10 18))]) ; Use a very large number for initial pushed flow
          (when (> pushed 0)
            (set! flow (+ flow pushed))
            (loop))))
    flow))

  (define min-cut-value (max-flow))

  ;; Calculate final score
  ;; Score = sum(grid[r][c]) - Adj_count + (sum_{P'_rc > 0} P'_rc - min_cut_value)
  ;; where P'_rc = 1 - grid[r][c]
  (define final-score
    (+ total-initial-grid-sum
       (- adj-count)
       total-p-prime-positive-sum
       (- min-cut-value)))

  final-score)

(define (make-queue)
  (let ([head '()]
        [tail '()])
    (define (empty?) (null? head))
    (define (add! item)
      (if (null? head)
          (begin (set! head (list item)) (set! tail head))
          (begin (set-cdr! tail (list item)) (set! tail (cdr tail)))))
    (define (remove!)
      (when (null? head) (error "Queue is empty"))
      (define item (car head))
      (set! head (cdr head))
      item)
    (list empty? add! remove!)))

(define (queue-empty? q) ((car q)))
(define (queue-add! q item) ((cadr q) item))
(define (queue-remove! q) ((caddr q)))

(define (list-set lst idx val)
  (cond
    [(zero? idx) (cons val (cdr lst))]
    [(null? lst) (error "list-set: index out of bounds")]
    [else (cons (car lst) (list-set (cdr lst) (- idx 1) val))]))