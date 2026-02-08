(define/contract (max-subarray-sum-divisible-by-k nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [prefix (make-vector (+ n 1) 0)]
         [mod-map (make-hash)]
         [result -inf.0])
    (hash-set! mod-map 0 0)
    (for ([i (in-range 1 (+ n 1))])
      (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref nums (- i 1))))
      (let* ([current-mod (modulo (vector-ref prefix i) k)]
             [current-mod (if (< current-mod 0) (+ current-mod k) current-mod)])
        (if (hash-has-key? mod-map current-mod)
            (set! result (max result (- (vector-ref prefix i) (hash-ref mod-map current-mod))))
            (void))
        (unless (hash-has-key? mod-map current-mod)
          (hash-set! mod-map current-mod (vector-ref prefix i)))))
    (if (= result -inf.0) 0 result)))