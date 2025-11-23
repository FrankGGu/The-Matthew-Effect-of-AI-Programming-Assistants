(define (findSneakyNumbers n)
  (define (is-sneaky? x)
    (let loop ((y x) (digit-sum 0))
      (cond
        [(zero? y) (= digit-sum 8)]
        [else (loop (floor (/ y 10)) (+ digit-sum (modulo y 10)))])))
  (define sneaky-numbers '())
  (for ((i (in-range 1 n)))
    (when (is-sneaky? i)
      (set! sneaky-numbers (cons i sneaky-numbers))))
  (reverse sneaky-numbers))

(define (findTwoSneakyNumbers n)
  (let ((sneaky-numbers (findSneakyNumbers n)))
    (if (< (length sneaky-numbers) 2)
        '()
        (list (list-ref sneaky-numbers 0) (list-ref sneaky-numbers 1)))))