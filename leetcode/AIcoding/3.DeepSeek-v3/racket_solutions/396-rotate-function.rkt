(define/contract (max-rotate-function nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (length nums)]
         [sum (apply + nums)]
         [f (lambda (k) (apply + (for/list ([i (in-range n)]) (* (list-ref nums i) (modulo (+ i k) n)))))]
         [f0 (f 0)]
         [result f0]
         [prev f0])
    (for ([k (in-range 1 n)])
      (let ([current (+ prev (- sum (* n (list-ref nums (- n k))))]))
        (set! result (max result current))
        (set! prev current))
    result))