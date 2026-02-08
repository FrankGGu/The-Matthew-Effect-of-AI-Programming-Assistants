(define (sum-digits num)
  (if (= num 0)
      0
      (+ (remainder num 10) (sum-digits (quotient num 10)))))

(define (minimum-addition-to-make-integer-beautiful n target)
  (let loop ((current-n n)
             (addition 0)
             (power-of-10 1))
    (if (<= (sum-digits current-n) target)
        addition
        (let ((remainder-val (remainder current-n power-of-10)))
          (if (= remainder-val 0)
              (loop current-n
                    addition
                    (* power-of-10 10))
              (let ((needed-for-next-power-of-10 (- power-of-10 remainder-val)))
                (loop (+ current-n needed-for-next-power-of-10)
                      (+ addition needed-for-next-power-of-10)
                      (* power-of-10 10))))))))