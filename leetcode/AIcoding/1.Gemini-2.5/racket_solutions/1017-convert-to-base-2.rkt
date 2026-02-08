(define (baseNeg2 n)
  (if (= n 0)
      "0"
      (let loop ((current-n n) (digits '()))
        (if (= current-n 0)
            (apply string-append digits)
            (let* ((r (modulo current-n 2))
                   (next-n (quotient (- current-n r) -2)))
              (loop next-n (cons (number->string r) digits)))))))