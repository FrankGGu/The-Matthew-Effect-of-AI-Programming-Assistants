(define/contract (find-peaks mountain)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([i 1] [n (length mountain)] [res '()])
    (if (>= i (- n 1))
        (reverse res)
        (let ([prev (list-ref mountain (- i 1))]
              [curr (list-ref mountain i)]
              [next (list-ref mountain (+ i 1))])
          (if (and (> curr prev) (> curr next))
              (loop (+ i 1) n (cons i res))
              (loop (+ i 1) n res))))))