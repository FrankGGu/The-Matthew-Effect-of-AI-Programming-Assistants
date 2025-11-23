#lang racket

(define (num-unique-digit-numbers n)
  (define (count i)
    (if (> i n)
        0
        (+ (if (= i 0) 1 (count-unique i)) (count (+ i 1)))))

  (define (count-unique x)
    (define digits (digits x))
    (define len (length digits))
    (define (helper pos used)
      (if (= pos len)
          1
          (let ((res 0))
            (for ([d (in-range (if (= pos 0) 1 0) 10)])
              (when (not (bitwise-and used (arithmetic-shift 1 d)))
                (set! res (+ res (helper (+ pos 1) (bitwise-ior used (arithmetic-shift 1 d))))))
            res)))
    (helper 0 0))

  (define (digits x)
    (if (= x 0)
        '()
        (append (digits (quotient x 10)) (list (remainder x 10))))

  (count 0))

(define (main)
  (define input (read))
  (display (num-unique-digit-numbers input)))

(main)