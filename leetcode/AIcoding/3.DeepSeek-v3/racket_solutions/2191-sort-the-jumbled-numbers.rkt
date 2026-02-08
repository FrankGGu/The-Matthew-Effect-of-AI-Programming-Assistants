(define/contract (sort-jumbled mapping nums)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (define (map-number num)
    (if (zero? num)
        (list-ref mapping 0)
        (let loop ([num num] [result 0] [power 1])
          (if (zero? num)
              result
              (let* ([digit (remainder num 10)]
                     [mapped-digit (list-ref mapping digit)]
                     [new-result (+ result (* mapped-digit power))])
                (loop (quotient num 10) new-result (* power 10)))))))
  (define nums-with-mapped
    (map (lambda (num) (cons num (map-number num))) nums))
  (map car
       (sort nums-with-mapped
             (lambda (a b)
               (or (< (cdr a) (cdr b))
                   (and (= (cdr a) (cdr b)) #f))))))