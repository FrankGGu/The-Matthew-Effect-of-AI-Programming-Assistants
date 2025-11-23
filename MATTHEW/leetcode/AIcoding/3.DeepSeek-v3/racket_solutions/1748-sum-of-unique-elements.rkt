(define/contract (sum-of-unique nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([lst nums] [counts (make-hash)] [sum 0])
    (cond
      [(null? lst)
       (for/sum ([(k v) (in-hash counts)] #:when (= v 1) k)]
      [else
       (let* ([num (car lst)]
              [new-count (add1 (hash-ref counts num 0))])
         (loop (cdr lst) (hash-set counts num new-count) sum))])))