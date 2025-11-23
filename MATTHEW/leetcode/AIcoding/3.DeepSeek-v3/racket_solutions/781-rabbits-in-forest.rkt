(define/contract (num-rabbits answers)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([counts (make-hash)]
              [ans answers]
              [result 0])
    (if (null? ans)
        result
        (let* ([num (car ans)]
               [key (add1 num)]
               [current (hash-ref counts num 0)])
          (if (zero? (modulo (add1 current) key))
              (loop (hash-set counts num (add1 current)) (cdr ans) (+ result key))
              (loop (hash-set counts num (add1 current)) (cdr ans) result))))))