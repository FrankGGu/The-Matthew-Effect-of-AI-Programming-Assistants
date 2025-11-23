(define/contract (sequential-digits low high)
  (-> exact-integer? exact-integer? (listof exact-integer?))
  (define (generate-sequential start)
    (let loop ([num start] [next (add1 start)] [res 0])
      (if (> next 9)
          (list res)
          (let ([new-num (+ (* num 10) next)])
            (cons res (loop new-num (add1 next) new-num))))))

  (define all-seq
    (sort
     (apply append
            (for/list ([i (in-range 1 10)])
              (generate-sequential i)))
     <))

  (filter (lambda (x) (and (>= x low) (<= x high))) all-seq))