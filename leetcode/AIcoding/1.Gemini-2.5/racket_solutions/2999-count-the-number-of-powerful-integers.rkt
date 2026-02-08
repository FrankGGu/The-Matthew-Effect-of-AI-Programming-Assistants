(define (count-powerful-integers start finish limit s)
  (define power-of-10-s (expt 10 s))

  ;; Helper function to count powerful integers up to a given number 'n'.
  ;; A powerful integer 'num' must satisfy num % (10^s) == limit.
  ;; This means num must be of the form k * (10^s) + limit for some integer k >= 0.
  ;; We need to count such 'num' where 1 <= num <= n.
  (define (count-up-to n)
    ;; Calculate the maximum possible value for k:
    ;; k * power-of-10-s + limit <= n
    ;; k * power-of-10-s <= n - limit
    ;; k <= (n - limit) / power-of-10-s
    (let* ([upper-k-bound (floor (/ (- n limit) power-of-10-s))])
      ;; The smallest valid k is 0 (which corresponds to num = limit).
      ;; So, k must be in the range [0, upper-k-bound].
      ;; The number of valid k values is (upper-k-bound - 0 + 1),
      ;; but only if upper-k-bound is non-negative.
      (if (>= upper-k-bound 0)
          (+ upper-k-bound 1)
          0)))

  ;; The count of powerful integers in [start, finish] is
  ;; (count up to finish) - (count up to start - 1).
  (- (count-up-to finish) (count-up-to (- start 1))))