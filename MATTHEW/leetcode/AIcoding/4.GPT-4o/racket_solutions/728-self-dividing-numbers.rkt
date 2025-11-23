(define (selfDividingNumbers left right)
  (define (is-self-dividing n)
    (define (helper n)
      (if (= n 0)
          #t
          (let ((digit (modulo n 10)))
            (if (or (= digit 0) (not (= 0 (modulo (quotient n 10) digit))))
                #f
                (helper (quotient n 10))))))
    (helper n))

  (define (filter-self-dividing lst)
    (filter is-self-dividing lst))

  (filter-self-dividing (build-list (- right left) (lambda (i) (+ left i)))))