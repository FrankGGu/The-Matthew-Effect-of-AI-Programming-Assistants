(define (is-monotonic? A)
  (or (apply <= A) (apply >= A)))