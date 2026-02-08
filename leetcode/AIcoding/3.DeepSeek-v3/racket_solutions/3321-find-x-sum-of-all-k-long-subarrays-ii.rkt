(define/contract (get-xor-sum arr k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i 0] [current-xor 0] [result 0])
    (if (>= i (length arr))
        result
        (let* ([current-xor (bitwise-xor current-xor (list-ref arr i))]
               [result (if (>= i (- k 1))
                           (bitwise-xor result current-xor)
                           result)])
          (loop (+ i 1) current-xor result)))))