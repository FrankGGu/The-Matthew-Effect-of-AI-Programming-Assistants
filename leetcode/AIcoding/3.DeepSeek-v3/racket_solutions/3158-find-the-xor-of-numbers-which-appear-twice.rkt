(define/contract (find-xor nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([seen (hash)]
             [nums nums]
             [result 0])
    (if (null? nums)
        result
        (let ([num (car nums)])
          (if (hash-has-key? seen num)
              (loop seen (cdr nums) (bitwise-xor result num))
              (loop (hash-set seen num #t) (cdr nums) result))))))