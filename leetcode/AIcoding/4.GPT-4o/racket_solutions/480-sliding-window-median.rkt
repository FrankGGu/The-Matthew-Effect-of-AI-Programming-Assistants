(define (median-finder)
  (define (insert sorted-list x)
    (cond
      [(null? sorted-list) (list x)]
      [(< x (car sorted-list)) (cons x sorted-list)]
      [else (cons (car sorted-list) (insert (cdr sorted-list) x))]))

  (define (remove sorted-list x)
    (cond
      [(null? sorted-list) '()]
      [(equal? x (car sorted-list)) (cdr sorted-list)]
      [else (cons (car sorted-list) (remove (cdr sorted-list) x))]))

  (define (find-median sorted-list)
    (let* ([n (length sorted-list)]
           [mid (/ n 2)])
      (if (even? n)
          (/ (+ (list-ref sorted-list (- mid 1)) (list-ref sorted-list mid)) 2.0)
          (list-ref sorted-list mid))))

  (define sorted-list '())
  (define (add x) (set! sorted-list (insert sorted-list x)))
  (define (remove-x x) (set! sorted-list (remove sorted-list x)))
  (define (get-median) (find-median sorted-list))

  (lambda (op . args)
    (cond
      [(equal? op 'add) (add (car args))]
      [(equal? op 'remove) (remove-x (car args))]
      [(equal? op 'get-median) (get-median)])))

(define sliding-window-median
  (lambda (nums k)
    (define finder (median-finder))
    (define result '())
    (define (slide i)
      (when (>= i k)
        (finder 'remove (list-ref nums (- i k)))
        (set! result (append result (list (finder 'get-median)))))
      (when (< i (length nums))
        (finder 'add (list-ref nums i))
        (slide (+ i 1))))
    (slide 0)
    result))