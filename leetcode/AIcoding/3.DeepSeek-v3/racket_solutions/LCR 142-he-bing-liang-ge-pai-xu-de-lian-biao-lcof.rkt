(define/contract (training-plan l1 l2)
  (-> (or/c null? list?) (or/c null? list?) (or/c null? list?))
  (let loop ([l1 l1] [l2 l2] [result null])
    (cond
      [(and (null? l1) (null? l2)) (reverse result)]
      [(null? l1) (loop l1 (cdr l2) (cons (car l2) result))]
      [(null? l2) (loop (cdr l1) l2 (cons (car l1) result))]
      [else
       (if (< (car l1) (car l2))
           (loop (cdr l1) l2 (cons (car l1) result))
           (loop l1 (cdr l2) (cons (car l2) result))])))