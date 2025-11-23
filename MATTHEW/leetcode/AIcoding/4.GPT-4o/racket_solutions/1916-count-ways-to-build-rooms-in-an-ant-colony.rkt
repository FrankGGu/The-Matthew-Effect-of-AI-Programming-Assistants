(define (count-ways rooms)
  (define mod 1000000007)
  (define n (length rooms))
  (define factorials (make-vector (+ n 1) 1))

  (for ([i (in-range 2 (+ n 1))])
    (vector-set! factorials i (modulo (* (vector-ref factorials (- i 1)) i) mod)))

  (define (dfs idx)
    (if (>= idx n) 1
        (let* ([total-ways (apply * (map dfs (vector->list (vector-ref rooms idx))))])
          (modulo (* (vector-ref factorials (+ (length (vector-ref rooms idx)) 1)) total-ways) mod))))

  (dfs 0))