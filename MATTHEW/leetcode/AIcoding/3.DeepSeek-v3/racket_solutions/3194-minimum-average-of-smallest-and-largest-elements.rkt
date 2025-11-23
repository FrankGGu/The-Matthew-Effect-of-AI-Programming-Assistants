(define/contract (minimum-average nums)
  (-> (listof exact-integer?) flonum?)
  (let* ([sorted (sort nums <)]
         [n (length nums)]
         [min-avg (fl+ (fl/ (exact->inexact (car sorted)) 2.0)
                       (fl/ (exact->inexact (last sorted)) 2.0))])
    (for/fold ([current-min min-avg])
              ([i (in-range 1 (quotient n 2))])
      (let* ([first-elem (list-ref sorted i)]
             [last-elem (list-ref sorted (- n i 1))]
             [avg (fl+ (fl/ (exact->inexact first-elem) 2.0)
                       (fl/ (exact->inexact last-elem) 2.0))])
        (if (fl< avg current-min) avg current-min)))))