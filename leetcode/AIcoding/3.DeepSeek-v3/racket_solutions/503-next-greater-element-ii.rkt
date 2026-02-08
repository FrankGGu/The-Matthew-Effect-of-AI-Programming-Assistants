(define/contract (next-greater-elements nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [nums-doubled (append nums nums)]
         [stack '()]
         [res (make-vector (* 2 n) -1)])
    (for ([i (in-range (* 2 n))])
      (let ([num (list-ref nums-doubled i)])
        (while (and (not (null? stack)) (> num (list-ref nums-doubled (car stack))))
          (vector-set! res (car stack) num)
          (set! stack (cdr stack)))
        (set! stack (cons i stack))))
    (take (vector->list res) n)))