(define (divisibilityArray word m)
  (let loop ([i 0]
             [remainder 0]
             [result '()])
    (if (= i (string-length word))
        (reverse result)
        (let* ([digit (- (char->integer (string-ref word i)) (char->integer #\0))]
               [new-remainder (modulo (+ (* remainder 10) digit) m)])
          (loop (+ i 1) new-remainder (cons (if (zero? new-remainder) 1 0) result))))))