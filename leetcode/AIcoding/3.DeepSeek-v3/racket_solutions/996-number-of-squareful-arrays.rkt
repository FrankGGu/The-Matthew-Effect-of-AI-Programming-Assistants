#lang racket

(define (num-squareful-perms nums)
  (define n (length nums))
  (define count 0)

  (define (is-square? x)
    (let ([s (sqrt x)])
      (= s (exact-floor s))))

  (define (permute lst used prev)
    (if (= (length used) n)
        (set! count (add1 count))
        (for ([i (in-range n)]
              #:unless (or (member i used)
                           (and (not (null? used))
                                (not (is-square? (+ prev (list-ref nums i)))))))
          (permute lst (cons i used) (list-ref nums i)))))

  (permute nums '() 0)
  count)