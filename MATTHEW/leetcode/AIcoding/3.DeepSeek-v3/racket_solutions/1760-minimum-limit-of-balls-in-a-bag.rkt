(define/contract (minimum-size nums ops)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (possible? max-size)
    (let loop ([nums nums] [ops-left ops])
      (cond
        [(null? nums) #t]
        [(> (car nums) max-size)
         (if (<= ops-left 0)
             #f
             (let ([q (quotient (car nums) max-size)]
                   [r (remainder (car nums) max-size)])
               (loop (cdr nums) (- ops-left (if (zero? r) (sub1 q) q)))))]
        [else (loop (cdr nums) ops-left)])))

  (let binary-search ([left 1] [right (apply max nums)])
    (if (= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (possible? mid)
              (binary-search left mid)
              (binary-search (add1 mid) right))))))