#lang racket

(define (kth-smallest-instructions destination k)
  (define m (car destination))
  (define n (cadr destination))

  (define C
    (let ([memo (make-hash)])
      (define (combinations n k)
        (cond
          ((< k 0) 0)
          ((> k n) 0)
          ((= k 0) 1)
          ((= k n) 1)
          (else
           (let ([key (cons n (min k (- n k)))])
             (hash-ref! memo key
                        (lambda ()
                          (+ (combinations (- n 1) k)
                             (combinations (- n 1) (- k 1)))))))))
      combinations))

  (define (solve d-rem r-rem current-k result-chars)
    (cond
      ((and (= d-rem 0) (= r-rem 0))
       (list->string (reverse result-chars)))

      ((= r-rem 0)
       (solve (- d-rem 1) r-rem current-k (cons #\D result-chars)))

      ((= d-rem 0)
       (solve d-rem (- r-rem 1) current-k (cons #\R result-chars)))

      (else
       (define count-if-R (C (+ (- r-rem 1) d-rem) (- r-rem 1)))

       (if (<= current-k count-if-R)
           (solve d-rem (- r-rem 1) current-k (cons #\R result-chars))
           (solve (- d-rem 1) r-rem (- current-k count-if-R) (cons #\D result-chars))))))

  (solve m n k '()))