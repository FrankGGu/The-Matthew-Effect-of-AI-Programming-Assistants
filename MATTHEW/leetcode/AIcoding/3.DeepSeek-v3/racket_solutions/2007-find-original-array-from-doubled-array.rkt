(define/contract (find-original-array changed)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([freq (make-hash)]
         [sorted-changed (sort changed <)]
         [n (length sorted-changed)]
         [result '()])
    (if (odd? n)
        '()
        (begin
          (for ([num sorted-changed])
            (hash-update! freq num add1 0))
          (for ([num sorted-changed] #:when (and (hash-ref freq num 0) (> (hash-ref freq num 0) 0)))
            (let ([double (* 2 num)])
              (if (hash-ref freq double 0)
                  (begin
                    (hash-update! freq num sub1)
                    (hash-update! freq double sub1)
                    (set! result (cons num result)))
                  (begin
                    (set! result '())
                    (break))))))
          (if (null? result)
              '()
              (reverse result))))))