(define (next-greater-balanced n)
  (define (is-balanced? num)
    (let loop ((digits (map string->number (string-split (number->string num) ""))))
      (if (null? digits)
          #t
          (let ((first (car digits))
                (rest (cdr digits)))
            (and (= first (if (null? rest) 0 (car rest)))
                 (loop rest))))))

  (define (next-greater num)
    (let loop ((current (+ num 1)))
      (if (is-balanced? current)
          current
          (loop (+ current 1)))))

  (next-greater n))