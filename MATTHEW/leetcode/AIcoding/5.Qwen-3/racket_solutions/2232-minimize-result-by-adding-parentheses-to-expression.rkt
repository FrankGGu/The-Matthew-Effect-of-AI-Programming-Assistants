#lang racket

(define (minimize-result expression)
  (define len (string-length expression))
  (define (eval-expr s)
    (define (helper s i)
      (cond [(= i (string-length s)) 0]
            [(char=? (string-ref s i) #\+) (+ (helper s (add1 i)) (helper s (add1 i)))]
            [(char=? (string-ref s i) #\-) (- (helper s (add1 i)) (helper s (add1 i)))]
            [(char=? (string-ref s i) #\*) (* (helper s (add1 i)) (helper s (add1 i)))]
            [(char=? (string-ref s i) #\/) (/ (helper s (add1 i)) (helper s (add1 i)))]
            [else (string->number (substring s i (add1 i)))]))
    (helper s 0))
  (define min-val (make-parameter 1e18))
  (for ([i (in-range (string-length expression))])
    (when (char=? (string-ref expression i) #\+)
      (for ([j (in-range (add1 i) (string-length expression))])
        (when (char=? (string-ref expression j) #\+)
          (let* ([left (substring expression 0 i)]
                 [mid (substring expression (add1 i) j)]
                 [right (substring expression (add1 j))])
            (let ([val (eval-expr (string-append left "+" mid "+" right))])
              (when (< val (parameter-ref min-val))
                (parameter-set! min-val val))))))))
  (parameter-ref min-val))