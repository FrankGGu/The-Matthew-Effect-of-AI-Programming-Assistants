(define (baseNeg2 n)
  (if (= n 0)
      "0"
      (let loop ((n n) (result ""))
        (if (= n 0)
            (reverse result)
            (begin
              (set! result (string-append (if (= (modulo n -2) 0) "0" "1") result))
              (loop (quotient (- n (if (= (modulo n -2) 0) 0 1)) -2) result))))))

(define (baseNeg2 n)
  (if (= n 0)
      "0"
      (let loop ((n n) (result ""))
        (if (= n 0)
            (reverse result)
            (begin
              (set! result (string-append (if (= (modulo n -2) 0) "0" "1") result))
              (loop (quotient (- n (if (= (modulo n -2) 0) 0 1)) -2) result))))))

(baseNeg2 n)