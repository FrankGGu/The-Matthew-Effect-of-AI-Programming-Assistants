(define/contract (max-score nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (factor-count n)
    (if (= n 1)
        1
        (let loop ([i 2] [count 1] [n n])
          (cond
            [(> (* i i) n) (if (> n 1) (* count 2) count)]
            [(= (modulo n i) 0)
             (let ([exp 0])
               (let inner ([n n] [exp exp])
                 (if (= (modulo n i) 0)
                     (inner (quotient n i) (+ exp 1))
                     (loop (+ i 1) (* count (+ exp 1)) n))))]
            [else (loop (+ i 1) count n)]))))
  (define sorted (sort nums >))
  (define (helper lst gcd-val score)
    (if (null? lst)
        score
        (let* ([new-gcd (gcd gcd-val (car lst))]
               [new-score (+ score (factor-count new-gcd))])
          (helper (cdr lst) new-gcd new-score))))
  (helper (cdr sorted) (car sorted) (factor-count (car sorted))))