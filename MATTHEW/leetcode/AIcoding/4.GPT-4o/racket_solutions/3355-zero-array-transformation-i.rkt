(define (can-transform-to-zero arr)
  (define (helper lst)
    (if (null? lst) #t
        (let loop ((current (car lst)) (rest (cdr lst)) (zero-count 0))
          (cond
            [(= current 0) (loop (if (null? rest) 0 (car rest)) (if (null? rest) '() (cdr rest)) (add1 zero-count))]
            [(> current 0) (if (> zero-count 0) (loop (if (null? rest) 0 (car rest)) (if (null? rest) '() (cdr rest)) 0) #f)]
            [else (loop (if (null? rest) 0 (car rest)) (if (null? rest) '() (cdr rest)) zero-count)]))))
  (helper arr))

(define (zero-array-transformation arr)
  (let loop ((nums arr))
    (if (null? nums) #t
        (let ((trans (can-transform-to-zero nums)))
          (if trans 
              (loop (filter (lambda (x) (not (= x 0))) nums))
              #f)))))

(zero-array-transformation '(0 1 2 0 0)) ; Example input