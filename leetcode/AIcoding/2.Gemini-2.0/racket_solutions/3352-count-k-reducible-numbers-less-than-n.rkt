(define (count-k-reducible-numbers n k)
  (define (digits x)
    (if (= x 0)
        '()
        (cons (modulo x 10) (digits (quotient x 10)))))

  (define (is-k-reducible? x k)
    (define ds (digits x))
    (define (sum-digits lst)
      (if (null? lst)
          0
          (+ (car lst) (sum-digits (cdr lst)))))

    (let loop ((num x) (sum (sum-digits ds)))
      (cond
        [(< num k) (= num 1)]
        [(= (modulo num k) 0) (loop (quotient num k) (sum-digits (digits (quotient num k))))]
        [else #f])))

  (let loop ((i 1) (count 0))
    (cond
      [(>= i n) count]
      [(is-k-reducible? i k) (loop (+ i 1) (+ count 1))]
      [else (loop (+ i 1) count)])))