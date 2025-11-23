(define mk-average
  (lambda (m k)
    (define total 0)
    (define values '())
    (define to-return '())

    (define (add num)
      (set! total (+ total 1))
      (set! values (cons num values))
      (if (= total m)
          (let* ((sorted (sort values <))
                 (start (if (<= k (length sorted)) k 0))
                 (end (if (<= k (length sorted)) (- (length sorted) k) (length sorted)))
                 (sum (apply + (sublist sorted start end))))
            (set! to-return (cons (/ sum (- m (* 2 k))) to-return))
            (set! values (cdr values))
            (set! total (- total 1)))))

    (define (get-mk-average)
      (if (null? to-return)
          -1
          (car (reverse to-return))))

    (define (process num)
      (add num)
      (get-mk-average))

    (lambda (op . args)
      (cond
        ((equal? op 'add) (apply process args))
        ((equal? op 'get-mk-average) (get-mk-average))))))

(define mk (mk-average 3 1))
(mk 'add 3)
(mk 'get-mk-average) ; returns -1
(mk 'add 1)
(mk 'get-mk-average) ; returns 1
(mk 'add 10)
(mk 'get-mk-average) ; returns 3
(mk 'add 5)
(mk 'get-mk-average) ; returns 5
(mk 'add 5)
(mk 'get-mk-average) ; returns 5