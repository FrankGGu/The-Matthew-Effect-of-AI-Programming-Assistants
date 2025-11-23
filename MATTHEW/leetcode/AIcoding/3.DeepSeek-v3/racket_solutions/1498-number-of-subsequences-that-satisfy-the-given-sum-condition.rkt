(define/contract (num-subseq nums target)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([nums (sort nums <)]
         [n (length nums)]
         [modulo (expt 10 9)]
         [add-modulo (lambda (x y) (modulo (+ x y) (+ modulo 7)))]
    (let loop ([left 0] [right (sub1 n)] [res 0])
      (if (> left right)
          res
          (let ([sum (+ (list-ref nums left) (list-ref nums right))])
            (if (<= sum target)
                (let ([power (expt 2 (- right left))])
                  (loop (add1 left) right (add-modulo res power)))
                (loop left (sub1 right) res))))))))