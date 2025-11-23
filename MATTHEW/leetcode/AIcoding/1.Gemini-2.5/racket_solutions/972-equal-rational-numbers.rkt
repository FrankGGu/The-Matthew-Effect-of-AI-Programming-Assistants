#lang racket

(require racket/string)
(require racket/match)

(define (string->rational s)
  (match (regexp-match #rx"^(\\d+)(?:\\.(\\d*))?(?:\\((\\d+)\\))?$" s)
    [(list _ A B C)
     (let* ((num-A (string->number A))
            (len-B (string-length B))
            (len-C (string-length C)))

       (if (= len-C 0)
           (if (= len-B 0)
               num-A
               (let* ((num-B (string->number B))
                      (power-of-10-B (expt 10 len-B)))
                 (+ num-A (/ num-B power-of-10-B))))
           (let* ((num-ABC (string->number (string-append A B C)))
                  (num-AB (string->number (string-append A B)))
                  (power-of-10-B (expt 10 len-B))
                  (power-of-10-C (expt 10 len-C)))
             (/ (- num-ABC num-AB) (* power-of-10-B (- power-of-10-C 1)))))]
    [_ (error "Invalid rational number string")]))

(define (equal-rational-numbers s t)
  (equal? (string->rational s) (string->rational t)))