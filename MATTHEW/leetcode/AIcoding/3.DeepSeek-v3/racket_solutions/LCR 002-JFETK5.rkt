(define (add-binary a b)
  (define (bin->dec s)
    (let loop ([s s] [acc 0])
      (if (string=? s "")
          acc
          (loop (substring s 1) (+ (* acc 2) (if (char=? (string-ref s 0) #\1) 1 0))))))
  (define (dec->bin n)
    (if (zero? n)
        "0"
        (let loop ([n n] [acc ""])
          (if (zero? n)
              (if (string=? acc "") "0" acc)
              (loop (quotient n 2) (string-append (if (odd? n) "1" "0") acc))))))
  (dec->bin (+ (bin->dec a) (bin->dec b))))