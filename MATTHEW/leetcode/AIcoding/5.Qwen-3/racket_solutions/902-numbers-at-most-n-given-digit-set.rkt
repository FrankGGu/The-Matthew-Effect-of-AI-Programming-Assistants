#lang racket

(define (num-at-most-n-with-digits digits n)
  (define len (string-length n))
  (define d-len (length digits))
  (define result 0)
  (define (digits->int s) (string->number s))
  (define (count-less-than-digits d)
    (for/sum ([i (in-range (index-of digits d))]) 1))
  (define (count-equal-digits d)
    (for/sum ([i (in-range (index-of digits d))]) (expt d-len i)))
  (define (count-more-than-digits d)
    (for/sum ([i (in-range (index-of digits d))]) (expt d-len i)))
  (define (helper s)
    (cond [(null? s) 0]
          [else
           (let* ([d (car s)]
                  [pos (index-of digits d)])
             (if (= pos -1)
                 0
                 (+ (* (expt d-len (- len (length s))) (count-less-than-digits d))
                    (if (= (length s) len)
                        (if (= (digits->int (list->string s)) (digits->int n))
                            (if (= (length s) len) 1 0)
                            0)
                        (helper (cdr s))))))]))
  (let loop ([s (string->list n)])
    (if (null? s)
        0
        (let* ([d (car s)]
               [pos (index-of digits d)])
          (if (= pos -1)
              (loop (cdr s))
              (+ (* (expt d-len (- len (length s))) (count-less-than-digits d))
                 (if (= (length s) len)
                     (if (= (digits->int (list->string s)) (digits->int n))
                         (if (= (length s) len) 1 0)
                         0)
                     (loop (cdr s))))))))
  (define (count-all)
    (for/sum ([i (in-range 1 len)]) (expt d-len i)))
  (+ (count-all) (helper (string->list n))))

(define (main)
  (define digits (string-split (read-line)))
  (define n (read-line))
  (printf "~a\n" (num-at-most-n-with-digits digits n)))

(main)