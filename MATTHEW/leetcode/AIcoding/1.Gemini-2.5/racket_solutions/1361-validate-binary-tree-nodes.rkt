(define (validate-binary-tree-nodes n leftChild rightChild)
  (call/cc (lambda (return-from-check)
    ;; Step 1: Check for multiple parents and count in-degrees
    (define parent-count (make-vector n 0))
    (for ([i (in-range n)])
      (let ([lc (vector-ref leftChild i)]
            [rc (vector-ref rightChild i)])
        (when (not (= lc -1))
          (vector-set! parent-count lc (+ (vector-ref parent-count lc) 1))
          (when (> (vector-ref parent-count lc) 1)
            (return-from-check #f)))
        (when (not (= rc -1))
          (vector-set! parent-count rc (+ (vector-ref parent-count rc) 1))
          (when (> (vector-ref parent-count rc) 1)
            (return-from-check #f)))))

    ;; Step 2: Find the root node
    (define root -1)
    (define root-candidates 0)
    (for ([i (in-range n)])
      (when (= (vector-ref parent-count i) 0)
        (set! root-candidates (+ root-candidates 1))
        (set! root i)))

    ;; Check for exactly one root
    (unless (= root-candidates 1)
      (return-from-check #f))

    ;; Manual queue implementation for BFS
    (define queue-in '())
    (define queue-out '())

    (define (queue-empty?) (and (null? queue-in) (null? queue-out)))
    (define (queue-put! item) (set! queue-in (cons item queue-in)))
    (define (queue-get!)
      (when (null? queue-out)
        (set! queue-out (reverse queue-in))
        (set! queue-in '()))
      (let ([item (car queue-out)])
        (set! queue-out (cdr queue-out))
        item))

    ;; Step 3: Perform BFS to check reachability and cycles
    (define visited (make-vector n #f))
    (queue-put! root)
    (vector-set! visited root #t)
    (define visited-count 1)

    (let bfs-loop ()
      (when (not (queue-empty?))
        (define current (queue-get!))
        (let ([lc (vector-ref leftChild current)]
              [rc (vector-ref rightChild current)])
          (when (not (= lc -1))
            (when (vector-ref visited lc)
              (return-from-check #f))
            (vector-set! visited lc #t)
            (set! visited-count (+ visited-count 1))
            (queue-put! lc))
          (when (not (= rc -1))
            (when (vector-ref visited rc)
              (return-from-check #f))
            (vector-set! visited rc #t)
            (set! visited-count (+ visited-count 1))
            (queue-put! rc)))
        (bfs-loop)))

    ;; Check if all nodes were visited
    (unless (= visited-count n)
      (return-from-check #f))

    #t)))