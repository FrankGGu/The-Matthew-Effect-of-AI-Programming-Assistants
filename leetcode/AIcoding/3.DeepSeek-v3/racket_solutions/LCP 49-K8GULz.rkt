#lang racket

(define/contract (can-complete-circuit gas cost)
  (-> (listof exact-integer?) (listof exact-integer?) boolean?)
  (let loop ([start 0] [current 0] [total 0] [tank 0])
    (if (>= start (length gas))
        (>= total 0)
        (let* ([current-gas (list-ref gas current)]
               [current-cost (list-ref cost current)]
               [new-tank (+ tank current-gas (- current-cost))])
          (if (< new-tank 0)
              (loop (add1 current) (add1 current) (+ total new-tank) 0)
              (let ([next (modulo (add1 current) (length gas))])
                (if (= next start)
                    (>= (+ total new-tank) 0)
                    (loop start next (+ total new-tank) new-tank)))))))