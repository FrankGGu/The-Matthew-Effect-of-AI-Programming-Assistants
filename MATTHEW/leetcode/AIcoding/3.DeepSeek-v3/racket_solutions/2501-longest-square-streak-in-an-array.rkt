(define/contract (longest-square-streak nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([nums-set (list->set nums)]
         [sorted (sort nums <)]
         [n (length nums)]
         [max-streak 0])
    (for ([num sorted])
      (let loop ([current num]
                 [streak 1])
        (let ([next (* current current)])
          (if (set-member? nums-set next)
              (loop next (+ streak 1))
              (set! max-streak (max max-streak streak))))))
    (if (< max-streak 2) -1 max-streak)))