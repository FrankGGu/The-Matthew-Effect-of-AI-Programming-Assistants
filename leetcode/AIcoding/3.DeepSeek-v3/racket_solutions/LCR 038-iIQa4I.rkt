(define/contract (daily-temperatures temperatures)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length temperatures)]
         [result (make-list n 0)]
         [stack '()])
    (for ([i (in-range n)])
      (let ([temp (list-ref temperatures i)])
        (while (and (not (null? stack))
                    (> temp (list-ref temperatures (car stack))))
          (let ([prev-index (car stack)])
            (list-set! result prev-index (- i prev-index))
            (set! stack (cdr stack)))))
      (set! stack (cons i stack)))
    result))