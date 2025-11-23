#lang racket

(define (max-bombs bombs)
  (define n (length bombs))
  (define adj (make-vector n '()))
  (for ([i (in-range n)])
    (for ([j (in-range n)])
      (when (and (not (= i j)) (<= (sqrt (+ (sqr (- (list-ref (list-ref bombs i) 0) (list-ref (list-ref bombs j) 0))) (sqr (- (list-ref (list-ref bombs i) 1) (list-ref (list-ref bombs j) 1))))) (list-ref (list-ref bombs i) 2)))
        (vector-set! adj i (cons j (vector-ref adj i))))))

  (define (dfs node visited)
    (let ([count 1])
      (for ([neighbor (vector-ref adj node)])
        (when (not (member neighbor visited))
          (set! count (+ count (dfs neighbor (cons neighbor visited))))))
      count))

  (define max-count 0)
  (for ([i (in-range n)])
    (set! max-count (max max-count (dfs i (list i)))))
  max-count)