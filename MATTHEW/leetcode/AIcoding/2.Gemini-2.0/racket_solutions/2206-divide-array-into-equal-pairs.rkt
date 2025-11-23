(define (divide-array nums)
  (define (count-frequencies lst)
    (cond [(empty? lst) '()]
          [else
           (let ((first (car lst))
                 (rest (cdr lst)))
             (let ((count (+ 1 (length (filter (lambda (x) (equal? x first)) rest)))))
               (cons (cons first count)
                     (count-frequencies (filter (lambda (x) (not (equal? x first))) rest)))))]))

  (let ((frequencies (count-frequencies nums)))
    (cond [(empty? frequencies) #t]
          [else
           (andmap (lambda (pair) (equal? (modulo (cdr pair) 2) 0)) frequencies)])))