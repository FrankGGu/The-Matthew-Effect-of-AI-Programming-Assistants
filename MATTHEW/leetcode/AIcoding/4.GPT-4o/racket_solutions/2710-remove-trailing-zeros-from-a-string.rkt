(define (removeTrailingZeros s)
  (let loop ((str s))
    (if (string=? (string-ref str (- (string-length str) 1)) #\0)
        (loop (substring str 0 (- (string-length str) 1)))
        str)))

(removeTrailingZeros "5123000") ; Expected output: "5123"
(removeTrailingZeros "12300")   ; Expected output: "123"
(removeTrailingZeros "12000")   ; Expected output: "12"
(removeTrailingZeros "0")       ; Expected output: "0"