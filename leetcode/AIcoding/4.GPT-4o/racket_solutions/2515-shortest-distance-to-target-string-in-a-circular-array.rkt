(define (closest-target words target start)
  (define n (length words))
  (define positions (for/list ([i (in-range n)] #:when (equal? (list-ref words i) target)) i))
  (if (null? positions)
      -1
      (define min-distance
        (for/fold ([min +inf.0]) ([pos positions])
          (min min (min (modulo (- pos start) n) (modulo (- start pos) n)))))
      min-distance)))

(closest-target '("a" "b" "leetcode" "c" "d") "leetcode" 0)
(closest-target '("a" "b" "leetcode" "c" "d") "a" 0)
(closest-target '("a" "b" "leetcode" "c" "d") "c" 1)