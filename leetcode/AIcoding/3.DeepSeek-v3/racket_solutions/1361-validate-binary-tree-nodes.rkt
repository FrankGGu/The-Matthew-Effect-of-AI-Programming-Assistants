(define/contract (validate-binary-tree-nodes n leftChild rightChild)
  (-> exact-integer? (listof exact-integer?) (listof exact-integer?) boolean?)
  (let ([in-degree (make-vector n 0)])
    (for ([i (in-range n)])
      (let ([left (list-ref leftChild i)]
            [right (list-ref rightChild i)])
        (when (>= left 0)
          (vector-set! in-degree left (+ (vector-ref in-degree left) 1)))
        (when (>= right 0)
          (vector-set! in-degree right (+ (vector-ref in-degree right) 1))))
    (let ([root-count 0]
          [root -1])
      (for ([i (in-range n)])
        (when (= (vector-ref in-degree i) 0)
          (set! root-count (+ root-count 1))
          (set! root i)))
      (unless (= root-count 1)
        (return #f))
      (let ([visited (make-vector n #f)]
            [queue (list root)])
        (vector-set! visited root #t)
        (let loop ([queue queue]
                   [visited-count 1])
          (if (null? queue)
              (= visited-count n)
              (let* ([node (car queue)]
                     [left (list-ref leftChild node)]
                     [right (list-ref rightChild node)]
                     [new-queue (cdr queue)])
                (when (>= left 0)
                  (if (vector-ref visited left)
                      (return #f)
                      (begin
                        (vector-set! visited left #t)
                        (set! new-queue (append new-queue (list left)))
                        (set! visited-count (+ visited-count 1)))))
                (when (>= right 0)
                  (if (vector-ref visited right)
                      (return #f)
                      (begin
                        (vector-set! visited right #t)
                        (set! new-queue (append new-queue (list right)))
                        (set! visited-count (+ visited-count 1)))))
                (loop new-queue visited-count))))))))