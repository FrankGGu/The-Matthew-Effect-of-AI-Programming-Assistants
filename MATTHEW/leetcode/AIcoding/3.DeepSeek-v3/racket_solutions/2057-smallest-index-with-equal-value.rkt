(define/contract (smallest-equal nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [lst nums])
    (cond
      [(null? lst) -1]
      [(= (modulo i 10) (car lst)) i]
      [else (loop (+ i 1) (cdr lst))])))