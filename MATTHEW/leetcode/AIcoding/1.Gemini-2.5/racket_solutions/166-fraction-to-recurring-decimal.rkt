#lang racket/base
(require racket/list)

(define (fraction-to-recurring-decimal numerator denominator)
  (when (= numerator 0)
    (string-append "0"))

  (let* ((negative? (xor (< numerator 0) (< denominator 0)))
         (abs-num (abs numerator))
         (abs-den (abs denominator))
         (integer-part (quotient abs-num abs-den))
         (remainder-val (remainder abs-num abs-den))
         (result-parts (list)))

    (when negative?
      (set! result-parts (append result-parts (list "-"))))

    (set! result-parts (append result-parts (list (number->string integer-part))))

    (when (> remainder-val 0)
      (set! result-parts (append result-parts (list ".")))
      (define seen-remainders (make-hash))

      (let loop ((rem remainder-val)
                 (idx (length result-parts)))
        (cond
          ((hash-has-key? seen-remainders rem)
           (define cycle-start-idx (hash-ref seen-remainders rem))
           (set! result-parts
                 (append (take result-parts cycle-start-idx)
                         (list "(")
                         (drop result-parts cycle-start-idx)
                         (list ")"))))
          ((= rem 0)
           #f)
          (else
           (hash-set! seen-remainders rem idx)
           (define new-num (* rem 10))
           (define digit (quotient new-num abs-den))
           (set! result-parts (append result-parts (list (number->string digit))))
           (loop (remainder new-num abs-den) (+ idx 1))))))

    (apply string-append result-parts)))