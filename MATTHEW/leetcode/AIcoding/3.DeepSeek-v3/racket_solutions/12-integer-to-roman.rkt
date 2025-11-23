(define (int-to-roman num)
  (let loop ((n num) (res ""))
    (cond
      [(>= n 1000) (loop (- n 1000) (string-append res "M"))]
      [(>= n 900) (loop (- n 900) (string-append res "CM"))]
      [(>= n 500) (loop (- n 500) (string-append res "D"))]
      [(>= n 400) (loop (- n 400) (string-append res "CD"))]
      [(>= n 100) (loop (- n 100) (string-append res "C"))]
      [(>= n 90) (loop (- n 90) (string-append res "XC"))]
      [(>= n 50) (loop (- n 50) (string-append res "L"))]
      [(>= n 40) (loop (- n 40) (string-append res "XL"))]
      [(>= n 10) (loop (- n 10) (string-append res "X"))]
      [(>= n 9) (loop (- n 9) (string-append res "IX"))]
      [(>= n 5) (loop (- n 5) (string-append res "V"))]
      [(>= n 4) (loop (- n 4) (string-append res "IV"))]
      [(>= n 1) (loop (- n 1) (string-append res "I"))]
      [else res])))