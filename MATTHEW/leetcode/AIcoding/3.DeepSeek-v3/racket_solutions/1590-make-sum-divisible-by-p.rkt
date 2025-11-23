(define/contract (min-subarray nums p)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([total (foldl + 0 nums)]
         [rem (modulo total p)]
         [n (length nums)]
         [result n])
    (if (zero? rem)
        0
        (let ([rem_map (make-hash)]
              [prefix 0])
          (hash-set! rem_map 0 -1)
          (for ([i (in-range n)])
            (set! prefix (modulo (+ prefix (list-ref nums i)) p))
            (let ([target (modulo (- prefix rem) p)])
              (when (hash-has-key? rem_map target)
                (set! result (min result (- i (hash-ref rem_map target))))))
            (hash-set! rem_map prefix i))
          (if (>= result n) -1 result)))))