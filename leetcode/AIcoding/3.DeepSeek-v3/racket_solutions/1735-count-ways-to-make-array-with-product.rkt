#lang racket

(require math/number-theory)

(define MOD 1000000007)

(define (factorize n)
  (define factors (factorize n))
  (if (null? factors)
      (list (cons n 1))
      factors))

(define (solve queries)
  (define max-k (apply max (map second queries)))
  (define max-n (apply max (map first queries)))

  (define comb (make-vector (+ max-n max-k 1) (make-vector (+ max-n max-k 1) 0)))

  (for ([i (in-range (+ max-n max-k 1))])
    (vector-set! (vector-ref comb i) 0 1)
    (for ([j (in-range 1 (+ i 1))])
      (vector-set! (vector-ref comb i) j 
                   (modulo (+ (vector-ref (vector-ref comb (- i 1)) (- j 1))
                             (vector-ref (vector-ref comb (- i 1)) j))
                           MOD))))

  (define (count-ways n k)
    (define factors (factorize k))
    (if (null? factors)
        (if (= k 1) 1 0)
        (let loop ([factors factors] [res 1])
          (if (null? factors)
              res
              (let* ([factor (car factors)]
                     [p (car factor)]
                     [e (cdr factor)]
                     [c (vector-ref (vector-ref comb (+ n e -1)) e]))
                (loop (cdr factors) (modulo (* res c) MOD))))))

  (map (lambda (q) (count-ways (first q) (second q))) queries))

(define (waysToFillArray queries)
  (solve queries))