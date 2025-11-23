(define/contract (distance nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([n (length nums)]
         [result (make-list n 0)]
         [indices (make-hash)])
    (for ([num nums] [i (in-naturals)])
    (hash-for-each indices (lambda (k v)
      (for ([i v])
        (list-set! result i (+ (list-ref result i) (abs (- i k))))))
    result))