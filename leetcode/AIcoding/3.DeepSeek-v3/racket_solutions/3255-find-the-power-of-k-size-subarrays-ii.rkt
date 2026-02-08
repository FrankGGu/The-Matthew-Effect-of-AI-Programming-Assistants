(define/contract (power-of-subarrays nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([n (length nums)]
         [prefix (make-vector (+ n 1) 0)]
         [result 0])
    (for ([i (in-range n)])
      (vector-set! prefix (+ i 1) (+ (vector-ref prefix i) (list-ref nums i))))
    (for ([i (in-range (- n k -1))])
      (let ([sum (- (vector-ref prefix (+ i k)) (vector-ref prefix i))])
        (set! result (+ result (* sum sum sum)))))
    result))