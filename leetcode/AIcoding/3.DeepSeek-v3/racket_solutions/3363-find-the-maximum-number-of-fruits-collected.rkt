(define/contract (max-total-fruits fruits startPos k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer?)
  (let* ([n (length fruits)]
         [pos-list (map (lambda (x) (first x)) fruits)]
         [amount-list (map (lambda (x) (second x)) fruits)]
         [prefix (make-vector (add1 n) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix (add1 i) (+ (vector-ref prefix i) (list-ref amount-list i))))
    (define (find-left pos)
      (let loop ([low 0] [high (sub1 n)])
        (if (> low high)
            -1
            (let* ([mid (quotient (+ low high) 2)]
                   [mid-pos (list-ref pos-list mid)])
              (cond
                [(< mid-pos pos) (loop (add1 mid) high)]
                [(> mid-pos pos) (loop low (sub1 mid))]
                [else mid])))))
    (define (find-right pos)
      (let loop ([low 0] [high (sub1 n)])
        (if (> low high)
            -1
            (let* ([mid (quotient (+ low high) 2)]
                   [mid-pos (list-ref pos-list mid)])
              (cond
                [(< mid-pos pos) (loop (add1 mid) high)]
                [(> mid-pos pos) (loop low (sub1 mid))]
                [else mid])))))
    (define (get-sum l r)
      (if (<= l r)
          (- (vector-ref prefix (add1 r)) (vector-ref prefix l))
          0))
    (define start-idx (find-left startPos))
    (if (= start-idx -1)
        (let ([left-idx (find-right startPos)])
          (if (= left-idx -1)
              0
              (let loop ([i left-idx] [max-fruits 0])
                (if (or (< i 0) (> (abs (- (list-ref pos-list i) startPos)) k))
                    max-fruits
                    (loop (sub1 i) (max max-fruits (get-sum i left-idx))))))
        (let loop ([i start-idx] [max-fruits 0])
          (if (or (>= i n) (> (abs (- (list-ref pos-list i) startPos)) k))
              max-fruits
              (loop (add1 i) (max max-fruits (get-sum start-idx i)))))))