#lang racket

(define (divide dividend divisor)
  (define (abs x)
    (if (< x 0) (- x) x))
  (define (sign x y)
    (if (= (bitwise-xor (bitwise-and x #x80000000) (bitwise-and y #x80000000)) #x80000000) -1 1))
  (define (divide-helper a b)
    (if (> a b)
        0
        (let loop ((count 0) (current b))
          (if (> current a)
              count
              (loop (+ count 1) (arithmetic-shift current 1))))))
  (define max-int 2147483647)
  (define min-int -2147483648)
  (if (and (= dividend 0) (= divisor 0))
      0
      (let ((a (abs dividend))
            (b (abs divisor)))
        (if (> a b)
            0
            (let ((result (divide-helper a b)))
              (if (> result max-int)
                  max-int
                  (if (< result min-int)
                      min-int
                      (* (sign dividend divisor) result))))))))