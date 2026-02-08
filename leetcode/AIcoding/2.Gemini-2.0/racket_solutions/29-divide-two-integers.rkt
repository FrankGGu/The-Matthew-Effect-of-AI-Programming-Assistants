(define (divide dividend divisor)
  (define INT_MAX 2147483647)
  (define INT_MIN -2147483648)

  (define (safe-abs x)
    (if (= x INT_MIN)
        INT_MAX
        (abs x)))

  (define (safe-neg x)
    (if (= x INT_MIN)
        INT_MAX
        (- x)))

  (define negative? (not (= (positive? dividend) (positive? divisor))))
  (define abs-dividend (safe-abs dividend))
  (define abs-divisor (safe-abs divisor))

  (if (< abs-dividend abs-divisor)
      0
      (let loop ((quotient 0) (temp-dividend abs-dividend))
        (if (< temp-dividend abs-divisor)
            (if negative?
                (safe-neg quotient)
                quotient)
            (let* ((shift 0))
              (let shift-loop ((shifted-divisor abs-divisor) (shift-count 0))
                (if (and (<= shifted-divisor (quotient INT_MAX 2)) (<= shifted-divisor temp-dividend))
                    (shift-loop (* shifted-divisor 2) (+ shift-count 1))
                    (set! shift (- shift-count 1))))
              (let ((shifted-divisor (arithmetic-shift abs-divisor shift)))
                (let ((shifted-quotient (arithmetic-shift 1 shift)))
                  (loop (+ quotient shifted-quotient) (- temp-dividend shifted-divisor))))))))

  )