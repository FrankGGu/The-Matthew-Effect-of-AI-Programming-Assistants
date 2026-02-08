(define/contract (ways-to-split nums)
  (-> (listof exact-integer?) exact-integer?)
  (define MOD 1000000007)
  (define n (length nums))
  (define prefix (make-vector (+ n 1) 0))
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref nums (- i 1)))))

  (define (binary-search-left left right target)
    (let loop ([low left] [high right] [res right])
      (if (> low high)
          res
          (let* ([mid (quotient (+ low high) 2)]
                 [sum (- (vector-ref prefix mid) (vector-ref prefix left))])
            (if (>= sum target)
                (loop low (- mid 1) mid)
                (loop (+ mid 1) high res)))))))

  (define (binary-search-right left right target)
    (let loop ([low left] [high right] [res left])
      (if (> low high)
          res
          (let* ([mid (quotient (+ low high) 2)]
                 [sum (- (vector-ref prefix mid) (vector-ref prefix left))])
            (if (<= sum target)
                (loop (+ mid 1) high mid)
                (loop low (- mid 1) res)))))))

  (define res 0)
  (for ([i (in-range 1 (- n 1))])
    (define left-sum (vector-ref prefix i))
    (define remaining-sum (- (vector-ref prefix n) left-sum))
    (if (>= remaining-sum (* 2 left-sum))
        (let* ([min-j (binary-search-left (+ i 1) (- n 1) left-sum)]
               [max-j (binary-search-right (+ i 1) (- n 1) (quotient remaining-sum 2))]
               [count (if (<= min-j max-j) (- max-j min-j -1) 0)])
          (set! res (modulo (+ res count) MOD)))
        (void)))
  res)