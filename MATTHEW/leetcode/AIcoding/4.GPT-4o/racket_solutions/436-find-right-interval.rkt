(define (find-right-interval intervals)
  (define n (length intervals))
  (define sorted-intervals (map (lambda (i) (list (car (list-ref intervals i)) i)) (range n)))
  (define sorted-intervals (sort sorted-intervals (lambda (a b) (< (car a) (car b)))))
  (define result (make-vector n -1))

  (for ([i (in-range n)])
    (define current-end (cadr (list-ref intervals i)))
    (define low (binary-search (lambda (x) (<= (car x) current-end)) sorted-intervals))
    (when low
      (vector-set! result i (cadr (list-ref low 0)))))

  (vector->list result))

(define (binary-search pred lst)
  (let loop ([low 0] [high (sub1 (length lst))])
    (if (> low high)
        #f
        (let* ([mid (quotient (+ low high) 2)]
               [value (list-ref lst mid)])
          (cond
            [(pred value) value]
            [else (loop (add1 mid) high)]
            [else (loop low (sub1 mid))])))))

(define (range n)
  (if (zero? n) '()
      (cons (sub1 n) (range (sub1 n)))))