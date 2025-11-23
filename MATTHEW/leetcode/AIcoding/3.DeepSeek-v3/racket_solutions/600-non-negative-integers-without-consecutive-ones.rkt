(define (find-integers n)
  (let* ([s (number->binary-string n)]
         [len (string-length s)]
         [dp (make-vector (add1 len) (make-vector 2 0))])
    (vector-set! (vector-ref dp len) 0 1)
    (vector-set! (vector-ref dp len) 1 1)
    (for ([i (in-range (- len 1) -1 -1)])
      (for ([prev (in-list '(0 1))])
        (let ([sum 0])
          (for ([curr (in-list '(0 1))])
            (when (or (not (= curr 1)) (not (= prev 1)))
              (when (<= (+ (* 2 sum) curr) (string->number (substring s i (+ i 1)) 2))
                (set! sum (+ sum (vector-ref (vector-ref dp (+ i 1)) curr))))))
          (vector-set! (vector-ref dp i) prev sum)))
    (vector-ref (vector-ref dp 0) 0)))

(define (number->binary-string n)
  (if (zero? n)
      "0"
      (let loop ([n n] [result ""])
        (if (zero? n)
            (if (string=? result "")
                "0"
                result)
            (loop (arithmetic-shift n -1) (string-append (if (odd? n) "1" "0") result)))))