(define/contract (longest-consecutive nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([num-set (list->set nums)]
        [max-len 0])
    (for ([num nums])
      (when (not (set-member? num-set (sub1 num)))
        (let ([current-num num]
              [current-len 1])
          (while (set-member? num-set (add1 current-num))
            (set! current-num (add1 current-num))
            (set! current-len (add1 current-len)))
          (set! max-len (max max-len current-len))))
    max-len))