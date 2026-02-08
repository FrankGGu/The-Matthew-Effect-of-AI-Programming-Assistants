(define/contract (longest-wpi hours)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [sum 0] [stk (list (cons -1 0))] [res 0] [hours hours])
    (if (null? hours)
        res
        (let* ([h (car hours)]
               [sum (+ sum (if (> h 8) 1 -1))]
               [new-stk (if (or (null? stk) (< sum (cdar stk))) 
                         (cons (cons i sum) stk)
                         stk)]
               [left 0]
               [right (sub1 (length new-stk))]
               [new-res res])
          (let bisect ([l left] [r right])
            (if (> l r)
                (loop (add1 i) sum new-stk new-res (cdr hours))
                (let* ([mid (quotient (+ l r) 2)]
                       [mid-val (cdr (list-ref new-stk mid))])
                  (if (< mid-val sum)
                      (begin
                        (set! new-res (max new-res (- i (car (list-ref new-stk mid)))))
                        (bisect l (sub1 mid)))
                      (bisect (add1 mid) r)))))))))