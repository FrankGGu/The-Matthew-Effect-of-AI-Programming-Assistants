#lang racket

(define (total-strength strength)
  (define mod 1000000007)
  (define n (length strength))
  (define prefix (make-vector (+ n 2) 0))
  (define prefix-prefix (make-vector (+ n 2) 0))
  (define left (make-vector n -1))
  (define right (make-vector n n))
  (define stack '())

  (for ([i (in-range n)])
    (vector-set! prefix (+ i 1) (modulo (+ (vector-ref prefix i) (list-ref strength i)) mod))

  (for ([i (in-range (+ n 1))])
    (vector-set! prefix-prefix (+ i 1) (modulo (+ (vector-ref prefix-prefix i) (vector-ref prefix i)) mod))

  (for ([i (in-range n)])
    (while (and (not (null? stack)) (< (list-ref strength (car stack)) (list-ref strength i)))
      (vector-set! right (car stack) i)
      (set! stack (cdr stack)))
    (if (not (null? stack))
        (vector-set! left i (car stack))
        (void))
    (set! stack (cons i stack)))

  (define res 0)
  (for ([i (in-range n)])
    (define l (vector-ref left i))
    (define r (vector-ref right i))
    (define total (modulo (- (* (vector-ref prefix-prefix (+ r 1)) (+ r (- i) 1))
                             (* (vector-ref prefix-prefix (+ i 1)) (+ r (- i) 1))
                             (* (vector-ref prefix-prefix (+ i 1)) (- i l))
                             (* (vector-ref prefix-prefix (+ l 1)) (- i l))))
                          mod))
    (set! res (modulo (+ res (* (modulo (* (list-ref strength i) total) mod)) mod)))

  res)