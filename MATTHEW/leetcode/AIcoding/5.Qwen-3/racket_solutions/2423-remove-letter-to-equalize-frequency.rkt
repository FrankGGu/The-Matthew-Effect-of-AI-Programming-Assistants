#lang racket

(define (equalize-frequency s)
  (define freq (make-hash))
  (for ([c s])
    (hash-set! freq c (+ 1 (hash-ref freq c 0))))
  (define counts (hash-values freq))
  (define (check? count)
    (andmap (lambda (x) (= x count)) counts))
  (if (check? (car counts))
      #t
      (let loop ([i 0])
        (if (= i (length counts))
            #f
            (let ([new-counts (append (take counts i) (drop counts (+ i 1)))])
              (if (check? (car new-counts))
                  #t
                  (loop (+ i 1))))))))

(define (remove-letter-to-equalize-frequency s)
  (equalize-frequency s))