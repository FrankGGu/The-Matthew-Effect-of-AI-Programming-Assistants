(define (num-similar-groups strs)
  (define n (length strs))
  (define strs-vec (list->vector strs))

  (define parent (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (define (find i)
    (cond
      [(= (vector-ref parent i) i) i]
      [else
       (define root (find (vector-ref parent i)))
       (vector-set! parent i root)
       root]))

  (define (union i j)
    (define root-i (find i))
    (define root-j (find j))
    (unless (= root-i root-j)
      (vector-set! parent root-i root-j)))

  (define (similar? s1 s2)
    (define len (string-length s1))
    (define diff-count 0)
    (for ([k (in-range len)])
      (when (not (char=? (string-ref s1 k) (string-ref s2 k)))
        (set! diff-count (+ diff-count 1))))
    (or (= diff-count 0) (= diff-count 2)))

  (for ([i (in-range n)])
    (for ([j (in-range (+ i 1) n)])
      (when (similar? (vector-ref strs-vec i) (vector-ref strs-vec j))
        (union i j))))

  (define num-groups 0)
  (for ([i (in-range n)])
    (when (= (vector-ref parent i) i)
      (set! num-groups (+ num-groups 1))))
  num-groups)