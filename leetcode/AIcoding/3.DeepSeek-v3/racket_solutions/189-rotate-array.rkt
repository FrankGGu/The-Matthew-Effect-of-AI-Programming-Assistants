(define/contract (rotate nums k)
  (-> (listof exact-integer?) exact-integer? void?)
  (let* ([n (length nums)]
         [k (modulo k n)]
         [rotated (append (drop nums (- n k)) (take nums (- n k)))])
    (set! nums rotated)))