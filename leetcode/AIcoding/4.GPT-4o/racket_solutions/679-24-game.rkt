(define (judge-point24 nums)
  (define (calc a b op)
    (cond
      [(equal? op '+) (+ a b)]
      [(equal? op '-) (- a b)]
      [(equal? op '*) (* a b)]
      [(equal? op '/) (if (zero? b) (error "division by zero") (/ a b))]))

  (define (evaluate expr)
    (if (null? expr) '()
        (let loop ((lst expr) (result '()))
          (cond
            [(null? lst) (if (null? result) #f (equal? (car result) 24))]
            [else
             (for ([i (in-range (length lst))])
               (for ([j (in-range (length lst))
                       #:when (not (= i j))])
                 (for ([op '(+ - * /)])
                   (let* ((a (list-ref lst i))
                          (b (list-ref lst j))
                          (new-lst (filter (lambda (x) (not (or (equal? x a) (equal? x b)))) lst)))
                     (let ((new-result (cons (calc a b op) new-lst)))
                       (when (evaluate new-result)
                         (set! result (cons (calc a b op) result))))))))
             (loop (cdr lst) result)))))

  (evaluate nums))