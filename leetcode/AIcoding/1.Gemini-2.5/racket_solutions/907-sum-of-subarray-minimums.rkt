#lang racket

(define (sum-subarray-minimums arr)
  (define MOD 1000000007)
  (define n (length arr))

  (define arr-vec (list->vector arr))

  (define left (make-vector n 0))
  (define stack '())

  (for ([i (in-range n)])
    (let loop ()
      (when (and (not (empty? stack))
                 (>= (vector-ref arr-vec (car stack)) (vector-ref arr-vec i)))
        (set! stack (cdr stack))
        (loop)))

    (let ([prev-smaller-idx (if (empty? stack) -1 (car stack))])
      (vector-set! left i (- i prev-smaller-idx)))

    (set! stack (cons i stack)))

  (define right (make-vector n 0))
  (set! stack '())

  (for ([i (in-range (- n 1) -1 -1)])
    (let loop ()
      (when (and (not (empty? stack))
                 (> (vector-ref arr-vec (car stack)) (vector-ref arr-vec i)))
        (set! stack (cdr stack))
        (loop)))

    (let ([next-smaller-equal-idx (if (empty? stack) n (car stack))])
      (vector-set! right i (- next-smaller-equal-idx i)))

    (set! stack (cons i stack)))

  (define total-sum 0)
  (for ([i (in-range n)])
    (set! total-sum
          (modulo (+ total-sum
                     (modulo (* (vector-ref arr-vec i)
                                (vector-ref left i)
                                (vector-ref right i))
                             MOD))
                  MOD)))

  total-sum)