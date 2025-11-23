#lang racket

(define (min-seconds-to-make-mountain-zero a)
  (define n (length a))
  (define res 0)
  (define (get-max-indexes)
    (for/fold ([max-indexes '()]) ([i (in-range n)])
      (if (or (null? max-indexes) (> (list-ref a i) (list-ref a (car max-indexes))))
          (cons i max-indexes)
          max-indexes)))
  (define (get-next-higher index)
    (let loop ([i (+ index 1)] [prev (list-ref a index)])
      (cond [(= i n) #f]
            [(> (list-ref a i) prev) i]
            [else (loop (+ i 1) prev)])))
  (define (get-prev-higher index)
    (let loop ([i (- index 1)] [prev (list-ref a index)])
      (cond [(< i 0) #f]
            [(> (list-ref a i) prev) i]
            [else (loop (- i 1) prev)])))
  (define (process index)
    (let ([next (get-next-higher index)]
          [prev (get-prev-higher index)])
      (when next
        (set! res (+ res (- (list-ref a next) (list-ref a index))))
        (set! a (list-set a next (list-ref a index))))
      (when prev
        (set! res (+ res (- (list-ref a prev) (list-ref a index))))
        (set! a (list-set a prev (list-ref a index))))))
  (for-each process (get-max-indexes))
  res)