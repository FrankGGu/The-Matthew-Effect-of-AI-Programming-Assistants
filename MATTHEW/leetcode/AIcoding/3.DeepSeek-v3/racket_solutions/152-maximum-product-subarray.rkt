(define/contract (max-product nums)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? nums)
      0
      (let loop ([i 1]
                 [max-so-far (first nums)]
                 [min-so-far (first nums)]
                 [result (first nums)])
        (if (= i (length nums))
            result
            (let* ([num (list-ref nums i)]
                   [temp-max (max num (* max-so-far num) (* min-so-far num))]
                   [temp-min (min num (* max-so-far num) (* min-so-far num))]
                   [new-result (max result temp-max)])
              (loop (add1 i) temp-max temp-min new-result))))))