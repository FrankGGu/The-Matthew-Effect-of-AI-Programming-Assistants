(define/contract (can-distribute nums quantity)
  (-> (listof exact-integer?) (listof exact-integer?) boolean?)
  (let* ([freq (make-hash)]
         [counts (for/list ([num nums])
                   (hash-update! freq num add1 0))]
         [freq-list (sort (hash-values freq) >)]
         [quantity (sort quantity >)]
         [m (length quantity)])
    (let loop ([i 0] [freq-list freq-list])
      (cond
        [(= i m) #t]
        [(null? freq-list) #f]
        [else
         (let ([q (list-ref quantity i)])
           (if (>= (car freq-list) q)
               (or (loop (add1 i) (cons (- (car freq-list) q) (cdr freq-list)))
                   (loop i (cdr freq-list)))
               (loop i (cdr freq-list))))]))))