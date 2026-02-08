(define (regions-cut-by-slashes grid)
  (define n (length grid))
  (define parent (make-vector (* 2 n n) -1))

  (define (find x)
    (if (vector-ref parent x)
        (find (vector-ref parent x))
        x))

  (define (union x y)
    (define rootX (find x))
    (define rootY (find y))
    (when (not (= rootX rootY))
      (vector-set! parent rootX rootY)))

  (define (index r c)
    (+ (* r (* 2 n)) (* c 2)))

  (for ([r (in-range n)]
        [c (in-range n)])
    (when (equal? (string-ref (list-ref grid r) c) #\/)
      (union (index r c) (index (+ r 1) c))
      (union (index r c) (index r (+ c 1))))
    (when (equal? (string-ref (list-ref grid r) c) #\\)
      (union (index r c) (index r (+ c 1)))
      (union (index r c) (index (+ r 1) c))))

  (define count 0)
  (for ([i (in-range (* 2 n n))])
    (when (equal? (find i) i)
      (set! count (+ count 1))))

  count)

(define (regions-cut-by-slashes grid)
  (regions-cut-by-slashes grid))