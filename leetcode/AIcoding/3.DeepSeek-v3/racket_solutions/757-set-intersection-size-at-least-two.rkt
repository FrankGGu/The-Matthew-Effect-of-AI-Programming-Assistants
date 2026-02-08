(define/contract (intersection-size-two intervals)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define sorted-intervals (sort intervals (lambda (a b) (or (< (second a) (second b)) (and (= (second a) (second b)) (> (first a) (first b))))))
  (define points '())
  (define (helper intervals points)
    (if (null? intervals)
        (length points)
        (let* ([current (car intervals)]
               [remaining (cdr intervals)]
               [intersect (filter (lambda (x) (and (>= x (first current)) (<= x (second current)))) points)]
               [count (length intersect)])
          (cond
            [(>= count 2) (helper remaining points)]
            [(= count 1) (helper remaining (cons (second current) points))]
            [else (helper remaining (cons (second current) (cons (- (second current) 1) points)))]))))
  (helper sorted-intervals points))