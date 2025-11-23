(define/contract (can-complete-circuit gas cost)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([start 0] [current 0] [total 0] [tank 0])
    (cond
      [(>= start (length gas)) -1]
      [(= current (+ start (length gas))) start]
      [else
       (let* ([pos (modulo current (length gas))]
              [new-tank (+ tank (list-ref gas pos) (- (list-ref cost pos)))])
         (if (< new-tank 0)
             (loop (add1 current) (add1 current) total 0)
             (loop start (add1 current) (+ total (list-ref gas pos) (- (list-ref cost pos))) new-tank)))])))