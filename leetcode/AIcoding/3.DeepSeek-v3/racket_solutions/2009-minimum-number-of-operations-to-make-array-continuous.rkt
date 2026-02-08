(define/contract (min-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [sorted (sort nums <)]
         [unique (remove-duplicates sorted)]
         [m (length unique)]
         [left 0]
         [right 0]
         [max-in-window 0])
    (for ([right (in-range m)])
    (let loop ([left 0] [right 0])
      (cond
        [(>= right m) (- n max-in-window)]
        [else
         (let* ([current-left (list-ref unique left)]
                [current-right (list-ref unique right)]
                [window-size (- current-right current-left -1)])
         (if (<= window-size n)
             (begin
               (set! max-in-window (max max-in-window (- right left -1)))
               (loop left (+ right 1)))
             (loop (+ left 1) right))]))))