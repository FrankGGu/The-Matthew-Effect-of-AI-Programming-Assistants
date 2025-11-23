(define/contract (maximize-min-score nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums (sort nums <)]
             [k k])
    (cond
      [(= k 0) (car nums)]
      [else (loop (sort (cons (+ (car nums) (cadr nums)) (cddr nums)) <) (sub1 k))])))