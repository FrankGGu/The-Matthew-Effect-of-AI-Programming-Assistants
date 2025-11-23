(define/contract (maximum-element-after-decrementing-and-rearranging arr)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([sorted-arr (sort arr <)]
         [n (length sorted-arr)])
    (if (null? sorted-arr)
        0
        (let loop ([lst (cdr sorted-arr)]
                   [prev 1]
                   [max-el 1])
          (if (null? lst)
              max-el
              (let ([current (min (car lst) (add1 prev))])
                (loop (cdr lst) current (max max-el current))))))))