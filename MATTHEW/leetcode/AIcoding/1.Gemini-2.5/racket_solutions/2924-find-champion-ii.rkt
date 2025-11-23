(define (find-champion-ii n battles)
  (define defeated (make-vector n #f)) ; #f means not defeated, #t means defeated

  (for-each (lambda (battle)
              (define loser (vector-ref battle 1))
              (vector-set! defeated loser #t))
            battles)

  (define champion-candidate -1)
  (define undefeated-count 0)

  (for ([i (in-range n)])
    (unless (vector-ref defeated i) ; If team i is not defeated
      (set! champion-candidate i)
      (set! undefeated-count (+ undefeated-count 1))))

  (if (= undefeated-count 1)
      champion-candidate
      -1))