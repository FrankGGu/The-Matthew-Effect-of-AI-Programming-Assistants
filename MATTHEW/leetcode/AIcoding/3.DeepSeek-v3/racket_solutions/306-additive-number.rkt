#lang racket

(define (is-additive-number num)
  (define (helper a b s)
    (cond
      [(string=? s "") #t]
      [else
       (let* ([sum (number->string (+ a b))]
              [len (string-length sum)])
         (and (>= (string-length s) len)
              (string=? (substring s 0 len) sum)
              (helper b (string->number sum) (substring s len))))]))

  (let ([n (string-length num)])
    (for*/or ([i (in-range 1 (add1 (quotient n 2)))]
              [j (in-range 1 (add1 (quotient (- n i) 2)))])
      (let* ([s1 (substring num 0 i)]
             [s2 (substring num i (+ i j))]
             [a (string->number s1)]
             [b (string->number s2)])
        (and (or (= (string-length s1) 1)
                 (not (string-prefix? s1 "0")))
             (or (= (string-length s2) 1)
                 (not (string-prefix? s2 "0")))
             (helper a b (substring num (+ i j)))))))))