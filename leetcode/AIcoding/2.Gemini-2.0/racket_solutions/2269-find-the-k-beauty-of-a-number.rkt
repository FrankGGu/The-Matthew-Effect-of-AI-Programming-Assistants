(define (divisor? num divisor)
  (zero? (modulo num divisor)))

(define (string->number str)
  (string->number/locale str #f))

(define (k-beauty num k)
  (let* ([s (number->string num)]
         [n (string-length s)])
    (let loop ([i 0] [count 0])
      (if (>= i (- n k -1))
          count
          (let ([sub-str (substring s i (+ i k))]
                [sub-num (string->number sub-str)])
            (if (and (not (zero? sub-num)) (divisor? num sub-num))
                (loop (+ i 1) (+ count 1))
                (loop (+ i 1) count)))))))