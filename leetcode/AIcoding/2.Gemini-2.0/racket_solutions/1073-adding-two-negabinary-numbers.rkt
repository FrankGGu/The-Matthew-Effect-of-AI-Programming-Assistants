(define (addNegabinary arr1 arr2)
  (define (to-decimal arr)
    (let loop ([arr arr] [power 1] [result 0])
      (if (null? arr)
          result
          (loop (cdr arr) (* -2 power) (+ result (* (car arr) power))))))

  (define (to-negabinary n)
    (if (= n 0)
        '(0)
        (let loop ([n n] [result '()])
          (if (= n 0)
              (if (null? result) '(0) (reverse result))
              (let* ([rem (remainder n -2)]
                     [next-n (quotient n -2)])
                (loop (+ next-n (if (< rem 0) 1 0))
                      (cons (if (< rem 0) (+ rem 2) rem) result)))))))

  (define sum (+ (to-decimal arr1) (to-decimal arr2)))

  (let* ([negabinary-result (to-negabinary sum)]
         [trimmed-result (let loop ([lst negabinary-result])
                            (cond
                              [(null? lst) '()]
                              [(= (length lst) 1) lst]
                              [(and (= (car lst) 0) (= (cadr lst) 0)) (loop (cdr lst))]
                              [else lst]))])
    trimmed-result))