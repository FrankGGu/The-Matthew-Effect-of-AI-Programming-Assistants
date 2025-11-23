(define/contract (most-competitive nums k)
  (-> (listof exact-integer?) exact-integer? (listof exact-integer?))
  (let loop ([stack '()] [nums nums] [remaining (- (length nums) k)])
    (cond
      [(zero? remaining) (append (reverse stack) nums)]
      [(null? nums) (take (reverse stack) k)]
      [(or (null? stack) 
           (<= (car nums) (car stack)) 
           (zero? remaining))
       (loop (cons (car nums) stack) (cdr nums) remaining)]
      [else (loop (cdr stack) nums (sub1 remaining))])))