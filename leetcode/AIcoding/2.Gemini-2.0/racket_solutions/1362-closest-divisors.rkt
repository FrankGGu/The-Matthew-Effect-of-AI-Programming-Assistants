(define (closest-divisors num1 num2)
  (define (find-divisors n)
    (let loop ([i (inexact->exact (floor (sqrt n)))]
               [divisors '()])
      (cond [(<= i 0) divisors]
            [(= (remainder n i) 0) (loop (sub1 i) (cons i (cons (/ n i) divisors)))]
            [else (loop (sub1 i) divisors)])))

  (define (find-closest-pair divisors)
    (let loop ([divisors divisors]
               [closest-pair '()]
               [min-diff +inf.0])
      (cond [(null? divisors) closest-pair]
            [else
             (let ([diff (abs (- (car divisors) (/ (car divisors) (first divisors)))))])
               (if (< diff min-diff)
                   (loop (cdr divisors) (list (car divisors) (/ (car divisors) (first divisors))) diff)
                   (loop (cdr divisors) closest-pair min-diff)))])))

  (define divisors1 (find-divisors (add1 num1)))
  (define divisors2 (find-divisors (add1 num2)))
  (define closest1 (find-closest-pair divisors1))
  (define closest2 (find-closest-pair divisors2))

  (define (calculate-diff pair)
    (abs (- (first pair) (second pair))))

  (if (< (calculate-diff closest1) (calculate-diff closest2))
      closest1
      closest2))

(define (closestDivisors n1 n2)
  (let* ([a (+ 1 n1)]
         [b (+ 1 n2)]
         [sqrt_a (inexact->exact (floor (sqrt a)))]
         [sqrt_b (inexact->exact (floor (sqrt b)))])

    (let loop ([i sqrt_a] [j sqrt_b])
      (cond
        [(and (<= i 0) (<= j 0)) (list 1 a)]
        [(<= i 0) (if (= (remainder b j) 0) (list j (/ b j)) (loop i (sub1 j)))]
        [(<= j 0) (if (= (remainder a i) 0) (list i (/ a i)) (loop (sub1 i) j))]
        [(= (remainder a i) 0)
         (if (= (remainder b j) 0)
             (let ([diff_a (abs (- i (/ a i)))]
                   [diff_b (abs (- j (/ b j)))])
               (if (< diff_a diff_b)
                   (list i (/ a i))
                   (list j (/ b j))))
             (loop (sub1 i) j))]
        [(= (remainder b j) 0) (loop i (sub1 j))]
        [else (let ([diff_a (abs (- i (/ a i)))]
                    [diff_b (abs (- j (/ b j)))]
                    [closest_a (if (and (> i 0) (= (remainder a i) 0)) (abs (- i (/ a i))) +inf.0)]
                    [closest_b (if (and (> j 0) (= (remainder b j) 0)) (abs (- j (/ b j))) +inf.0)])
                (cond
                  [(< closest_a closest_b) (loop (sub1 i) j)]
                  [else (loop i (sub1 j))]))])))))