(define/contract (minimum-operations num)
  (-> string? exact-integer?)
  (define (divisible-by-25? s)
    (let loop ([i (sub1 (string-length s))] [count 0] [target "52"])
      (cond
        [(or (< i 0) (>= count 2)) (= count 2)]
        [(equal? (string-ref s i) (string-ref target (modulo count 2)))
         (loop (sub1 i) (add1 count) target)]
        [else (loop (sub1 i) count target)])))
  (define n (string-length num))
  (define min-ops n)
  (for ([target '("00" "25" "50" "75")])
    (let loop ([i (sub1 n)] [count 0] [pos 1])
      (cond
        [(or (< i 0) (> pos 1)) (when (>= pos 1) (set! min-ops (min min-ops (- n count))))]
        [(equal? (string-ref num i) (string-ref target (modulo pos 2)))
         (loop (sub1 i) (add1 count) (add1 pos))]
        [else (loop (sub1 i) count pos)])))
  (if (divisible-by-25? num) 0 min-ops))