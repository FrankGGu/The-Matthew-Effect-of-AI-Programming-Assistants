#lang racket

(define (most-frequent-prime mat)
  (define rows (length mat))
  (define cols (if (null? mat) 0 (length (car mat))))

  (define (get-number i j di dj len)
    (let loop ([x i] [y j] [n 0] [k 0])
      (if (or (>= k len) (< x 0) (>= x rows) (< y 0) (>= y cols))
          (if (>= k 1) n #f)
          (loop (+ x di) (+ y dj) (+ (* n 10) (list-ref (list-ref mat x) y)) (+ k 1)))))

  (define (is-prime? n)
    (if (<= n 1)
        #f
        (let loop ([i 2])
          (if (> (* i i) n)
              #t
              (if (zero? (modulo n i))
                  #f
                  (loop (+ i 1))))))

  (define primes (make-hash))
  (define max-count 0)
  (define result -1)

  (define dirs '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1)))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (for ([dir dirs])
        (define di (car dir))
        (define dj (cadr dir))
        (for ([len (in-range 1 (+ (max rows cols) 1))])
          (define num (get-number i j di dj len))
          (when (and num (>= num 10) (is-prime? num))
            (hash-update! primes num (lambda (v) (+ v 1)) 1)
            (define cnt (hash-ref primes num))
            (cond
              [(> cnt max-count)
               (set! max-count cnt)
               (set! result num)]
              [(= cnt max-count)
               (when (> num result)
                 (set! result num))]))))))

  result)