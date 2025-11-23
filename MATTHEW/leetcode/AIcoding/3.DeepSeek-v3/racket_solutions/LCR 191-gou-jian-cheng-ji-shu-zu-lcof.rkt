(define/contract (statistical-result nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define n (length nums))
  (define prefix (make-list n 1))
  (define suffix (make-list n 1))

  (for ([i (in-range 1 n)])
    (list-set! prefix i (* (list-ref prefix (- i 1)) (list-ref nums (- i 1)))))

  (for ([i (in-range (- n 2) -1 -1)])
    (list-set! suffix i (* (list-ref suffix (+ i 1)) (list-ref nums (+ i 1)))))

  (for/list ([i (in-range n)])
    (* (list-ref prefix i) (list-ref suffix i))))
)