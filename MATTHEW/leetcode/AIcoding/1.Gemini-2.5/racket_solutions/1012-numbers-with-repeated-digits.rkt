#lang racket

(define (P n k)
  (cond
    ((< k 0) 0)
    ((= k 0) 1)
    ((> k n) 0)
    (else
     (for/product ([i (in-range (- n k -1) (+ n 1))])
       i))))

(define (num-dup-digits n)
  (define n-str (number->string n))
  (define len (string-length n-str))
  (define digits (map (lambda (c) (- (char->integer c) (char->integer #\0)))
                      (string->list n-str)))

  (define count-no-repeat 0)

  (for ([k (in-range 1 len)])
    (set! count-no-repeat
          (+ count-no-repeat
             (* 9 (P 9 (- k 1))))))

  (define used-digits (make-set))
  (define found-repeat #f)

  (let loop ([idx 0] [remaining-digits digits])
    (when (not (null? remaining-digits))
      (define d (car remaining-digits))

      (for ([j (in-range (if (= idx 0) 1 0) d)])
        (when (not (set-member? used-digits j))
          (set! count-no-repeat
                (+ count-no-repeat
                   (P (- 10 (add1 idx)) (- len (add1 idx)))))))

      (when (set-member? used-digits d)
        (set! found-repeat #t))

      (set-add! used-digits d)

      (unless found-repeat
        (loop (add1 idx) (cdr remaining-digits)))))

  (when (not found-repeat)
    (set! count-no-repeat (add1 count-no-repeat)))

  (- n count-no-repeat))