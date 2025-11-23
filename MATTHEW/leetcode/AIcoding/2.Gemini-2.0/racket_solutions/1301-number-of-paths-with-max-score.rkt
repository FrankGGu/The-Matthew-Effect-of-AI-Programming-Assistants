(define (paths-with-max-score board)
  (define n (vector-length board))
  (define mod 1000000007)

  (define dp (make-vector (add1 n) (make-vector (add1 n) 0)))
  (define count (make-vector (add1 n) (make-vector (add1 n) 0)))

  (vector-set! (vector-ref count n) n 1)

  (for* ([i (in-range (sub1 n) -1 -1)]
         [j (in-range (sub1 n) -1 -1)])
    (define cell (vector-ref (vector-ref board i) j))
    (unless (equal? cell #\X)
      (define max-score 0)
      (define num-paths 0)

      (define down-score (vector-ref (vector-ref dp (add1 i)) j))
      (define right-score (vector-ref (vector-ref dp i) (add1 j)))
      (define diag-score (vector-ref (vector-ref dp (add1 i)) (add1 j)))

      (define down-paths (vector-ref (vector-ref count (add1 i)) j))
      (define right-paths (vector-ref (vector-ref count i) (add1 j)))
      (define diag-paths (vector-ref (vector-ref count (add1 i)) (add1 j)))

      (when (> down-paths 0)
        (when (> (+ down-score (if (equal? cell #\S) 0 (string->number (string cell)))) max-score)
          (set! max-score (+ down-score (if (equal? cell #\S) 0 (string->number (string cell)))))
          (set! num-paths down-paths))
        (when (equal? (+ down-score (if (equal? cell #\S) 0 (string->number (string cell)))) max-score)
          (set! num-paths (modulo (+ num-paths down-paths) mod))))

      (when (> right-paths 0)
        (when (> (+ right-score (if (equal? cell #\S) 0 (string->number (string cell)))) max-score)
          (set! max-score (+ right-score (if (equal? cell #\S) 0 (string->number (string cell)))))
          (set! num-paths right-paths))
        (when (equal? (+ right-score (if (equal? cell #\S) 0 (string->number (string cell)))) max-score)
          (set! num-paths (modulo (+ num-paths right-paths) mod))))

      (when (> diag-paths 0)
        (when (> (+ diag-score (if (equal? cell #\S) 0 (string->number (string cell)))) max-score)
          (set! max-score (+ diag-score (if (equal? cell #\S) 0 (string->number (string cell)))))
          (set! num-paths diag-paths))
        (when (equal? (+ diag-score (if (equal? cell #\S) 0 (string->number (string cell)))) max-score)
          (set! num-paths (modulo (+ num-paths diag-paths) mod))))

      (vector-set! (vector-ref dp i) j max-score)
      (vector-set! (vector-ref count i) j num-paths)))

  (list (vector-ref (vector-ref dp 0) 0) (vector-ref (vector-ref count 0) 0)))