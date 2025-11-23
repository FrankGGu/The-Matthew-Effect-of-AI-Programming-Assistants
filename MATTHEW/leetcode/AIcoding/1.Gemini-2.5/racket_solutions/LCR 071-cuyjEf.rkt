#lang racket

(define (Solution w)
  (let* ([prefix-sums (let loop ([weights w] [current-sum 0] [acc '()])
                        (if (empty? weights)
                            (reverse acc)
                            (let ([new-sum (+ current-sum (car weights))])
                              (loop (cdr weights) new-sum (cons new-sum acc)))))])
         [total-sum (if (empty? w) 0 (last prefix-sums))])

    (lambda ()
      (when (empty? w)
        (error "Cannot pick from empty weights list."))

      (let ([target (+ 1 (random total-sum))])
        (let binary-search-loop ([low 0] [high (- (length prefix-sums) 1)])
          (if (> low high)
              low
              (let ([mid (+ low (quotient (- high low) 2))])
                (if (>= (list-ref prefix-sums mid) target)
                    (binary-search-loop low (- mid 1))
                    (binary-search-loop (+ mid 1) high)))))))))