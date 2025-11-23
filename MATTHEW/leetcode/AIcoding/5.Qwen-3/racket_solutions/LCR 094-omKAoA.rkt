#lang racket

(define (is-palindrome s start end)
  (let loop ([i start] [j end])
    (cond [(>= i j) #t]
          [(char=? (string-ref s i) (string-ref s j)) (loop (+ i 1) (- j 1))]
          [else #f])))

(define (min-cut s)
  (define n (string-length s))
  (define dp (make-vector n n))
  (define is-pal (make-vector n (make-vector n #f)))
  (for ([i (in-range n)])
    (vector-set! dp i (- n 1))
    (for ([j (in-range i n)])
      (when (and (char=? (string-ref s i) (string-ref s j)) (or (< i (+ j 1)) (vector-ref (vector-ref is-pal i) (+ j 1))))
        (vector-set! (vector-ref is-pal i) j #t)
        (if (= i 0)
            (vector-set! dp j (- j 1))
            (vector-set! dp j (min (vector-ref dp j) (+ (vector-ref dp (- i 1)) 1)))))))
  (vector-ref dp (- n 1)))