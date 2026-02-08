(define/contract (subarrays-div-by-k nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let ([prefix 0]
        [count 0]
        [mod-map (make-hash '((0 . 1)))])
    (for ([num (in-list nums)])
      (set! prefix (+ prefix num))
      (let ([mod (modulo prefix k)])
        (when (< mod 0)
          (set! mod (+ mod k)))
        (set! count (+ count (hash-ref mod-map mod 0)))
        (hash-update! mod-map mod add1 0)))
    count))