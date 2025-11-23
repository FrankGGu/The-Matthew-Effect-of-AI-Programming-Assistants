(define (numDupDigitsAtMostN N)
  (define (count-unique n)
    (define digits (string->list (number->string n)))
    (define len (length digits))
    (define (helper pos used repeated)
      (cond
        [(= pos len) 1]
        [else
         (let* ([current-digit (- (char->integer (list-ref digits pos)) 48)]
               [start (if (= pos 0) 1 0)]
               [end (if repeated 9 (sub1 current-digit))]
               [total 0])
           (for ([d (in-range start (add1 end))])
             (if (bitwise-bit-set? used d)
                 (set! total (+ total (helper (add1 pos) used #t)))
                 (set! total (+ total (helper (add1 pos) (bitwise-ior used (arithmetic-shift 1 d)) repeated))))
           (if (and (not repeated) (> d end))
               (set! total (+ total (helper (add1 pos) used repeated)))
           total)]))
    (helper 0 0 #f))
  (- N (count-unique N)))