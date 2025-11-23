#lang racket

(define (count-special-substrings s k)
  (define n (string-length s))
  (define (is-special? c)
    (or (char=? c #\a) (char=? c #\e) (char=? c #\i) (char=? c #\o) (char=? c #\u)))

  (let loop ([i 0] [count 0] [result 0])
    (cond
      [(>= i n) result]
      [(is-special? (string-ref s i))
       (let ([new-count (add1 count)])
         (if (= new-count k)
             (loop (add1 i) 0 (add1 result))
             (loop (add1 i) new-count result)))]
      [else (loop (add1 i) count result)])))

(define (max-disjoint-special-substrings s k)
  (define n (string-length s))
  (define (is-special? c)
    (or (char=? c #\a) (char=? c #\e) (char=? c #\i) (char=? c #\o) (char=? c #\u)))

  (let loop ([i 0] [count 0] [result 0] [last-end -1])
    (cond
      [(>= i n) result]
      [(is-special? (string-ref s i))
       (let ([new-count (add1 count)])
         (if (= new-count k)
             (loop (add1 i) 0 (add1 result) i)
             (loop (add1 i) new-count result last-end)))]
      [else (loop (add1 i) count result last-end)])))

(define (max-k-disjoint-special-substrings s k)
  (max-disjoint-special-substrings s k))