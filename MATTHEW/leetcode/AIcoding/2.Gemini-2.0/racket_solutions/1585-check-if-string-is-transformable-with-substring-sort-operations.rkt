(define (is-transformable s t)
  (define s-indices (make-vector 10 '()))
  (define t-indices (make-vector 10 '()))

  (for ([i (in-range (string-length s))])
    (let ([digit (string->number (string (string-ref s i)))])
      (vector-set! s-indices digit (append (vector-ref s-indices digit) (list i)))))

  (for ([i (in-range (string-length t))])
    (let ([digit (string->number (string (string-ref t i)))])
      (vector-set! t-indices digit (append (vector-ref t-indices digit) (list i)))))

  (define (check-order s-indices t-indices)
    (for ([digit (in-range 10)])
      (let ([s-list (vector-ref s-indices digit)]
            [t-list (vector-ref t-indices digit)])
        (cond
          [(empty? t-list) #t]
          [(empty? s-list) #f]
          [else
           (let loop ([t-head (car t-list)]
                      [t-tail (cdr t-list)]
                      [s-list s-indices])
             (cond
               [(empty? s-list) #f]
               [(< (car s-list) t-head)
                (let ([smaller-digits (filter (lambda (d) (< d digit)) (range 10))])
                  (cond
                    [(empty? smaller-digits) (loop t-head t-tail (cdr s-list))]
                    [else
                     (let check-smaller ([smaller-list smaller-digits])
                       (cond
                         [(empty? smaller-list) (loop t-head t-tail (cdr s-list))]
                         [else
                          (let ([smaller-digit (car smaller-list)])
                            (if (ormap (lambda (idx) (< idx (car s-list))) (vector-ref s-indices smaller-digit))
                                #f
                                (check-smaller (cdr smaller-list))))]))]))]
               [else
                (if (empty? t-tail)
                    #t
                    (check-order (vector-set s-indices digit (cdr s-list)) (vector-set t-indices digit t-tail)))]))]))))

  (check-order s-indices t-indices))