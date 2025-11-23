#lang racket

(define (minimum-beautiful-substrings s)
  (define n (string-length s))
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)
  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 0 i)])
      (define substr (substring s j i))
      (when (and (not (equal? (string-ref substr 0) #\0))
                 (is-power-of-5 (binary->decimal substr)))
        (vector-set! dp i (min (vector-ref dp i)
                               (+ (vector-ref dp j) 1))))))
  (define result (vector-ref dp n))
  (if (equal? result +inf.0) -1 result))

(define (is-power-of-5 num)
  (if (zero? num) #f
      (let loop ([n num])
        (cond [(= n 1) #t]
              [(not (zero? (remainder n 5))) #f]
              [else (loop (/ n 5))]))))

(define (binary->decimal s)
  (define len (string-length s))
  (define (helper i acc)
    (if (= i len) acc
        (helper (+ i 1) (+ (* acc 2) (if (equal? (string-ref s i) #\1) 1 0)))))
  (helper 0 0))