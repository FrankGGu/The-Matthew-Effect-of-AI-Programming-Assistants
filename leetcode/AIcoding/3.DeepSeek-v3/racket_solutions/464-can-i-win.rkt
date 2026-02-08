#lang racket

(define (can-i-win max-choosable-integer desired-total)
  (if (<= desired-total 0)
      #t
      (let ([sum (/ (* max-choosable-integer (add1 max-choosable-integer)) 2)])
        (if (< sum desired-total)
            #f
            (let ([memo (make-hash)])
              (define (helper used remaining)
                (if (hash-has-key? memo used)
                    (hash-ref memo used)
                    (let ([result #f])
                      (for ([i (in-range 1 (add1 max-choosable-integer))] #:break result)
                        (unless (bitwise-bit-set? used i)
                          (if (>= i remaining)
                              (set! result #t)
                              (unless (helper (bitwise-ior used (arithmetic-shift 1 i)) (- remaining i))
                                (set! result #t)))))
                      (hash-set! memo used result)
                      result)))
              (helper 0 desired-total))))))