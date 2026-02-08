(define/contract (busy-student start-time end-time query-time)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer? exact-integer?)
  (count (lambda (s e) (and (<= s query-time) (>= e query-time))) start-time end-time))