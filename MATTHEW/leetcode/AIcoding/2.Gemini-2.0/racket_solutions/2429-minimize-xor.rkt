(define (minimize-xor num1 num2)
  (let* ([bits1 (integer->list num1)]
         [bits2 (integer->list num2)]
         [count2 (length (filter (lambda (x) (= x 1)) bits2))]
         [result 0])
    (for ([i (in-range 31 -1 -1)])
      (if (and (> count2 0) (bit-set? num1 i))
          (begin
            (set! result (+ result (expt 2 i)))
            (set! count2 (- count2 1)))))
    (for ([i (in-range 0 32)])
      (if (and (> count2 0) (not (bit-set? result i)))
          (begin
            (set! result (+ result (expt 2 i)))
            (set! count2 (- count2 1)))))
    result))

(define (integer->list n)
  (let loop ([n n] [acc '()])
    (if (= n 0)
        acc
        (loop (arithmetic-shift n -1) (cons (modulo n 2) acc)))))

(define (bit-set? num i)
  (= 1 (bitwise-and (arithmetic-shift 1 i) num)))