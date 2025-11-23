(define/contract (min-operations nums)
  (-> (listof exact-integer?) exact-integer?)
  (define (count-ones n)
    (let loop ([n n] [cnt 0])
      (cond [(zero? n) cnt]
            [(odd? n) (loop (arithmetic-shift n -1) (add1 cnt))]
            [else (loop (arithmetic-shift n -1) cnt)])))
  (define (count-divs n)
    (let loop ([n n] [cnt 0])
      (cond [(zero? n) cnt]
            [else (loop (arithmetic-shift n -1) (add1 cnt))])))
  (let ([max-div 0]
        [total-ones 0])
    (for ([num nums])
      (set! total-ones (+ total-ones (count-ones num)))
      (set! max-div (max max-div (count-divs num))))
    (+ total-ones (if (zero? max-div) 0 (sub1 max-div)))))