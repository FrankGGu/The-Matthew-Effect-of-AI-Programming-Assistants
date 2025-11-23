#lang racket

(define MOD 1000000007)

(define (number-of-ways num)
  (define n (string-length num))
  (define dp (make-vector (add1 n) 0))
  (define dp-prefix (make-vector (add1 n) 0))
  (define lcp (make-vector (add1 n) (make-vector (add1 n) 0)))

  (for* ([i (in-range n 0 -1)]
         [j (in-range n 0 -1)])
    (if (or (= i n) (= j n))
        (vector-set! (vector-ref lcp i) j 0)
        (if (char=? (string-ref num i) (string-ref num j))
            (vector-set! (vector-ref lcp i) j (add1 (vector-ref (vector-ref lcp (add1 i)) (add1 j))))
            (vector-set! (vector-ref lcp i) j 0))))

  (vector-set! dp 0 1)
  (vector-set! dp-prefix 0 1)

  (for ([i (in-range 1 (add1 n))])
    (vector-set! dp-prefix i (vector-ref dp-prefix (sub1 i)))
    (for ([j (in-range 1 (add1 i))])
      (if (char=? (string-ref num (- i j)) #\0)
          (vector-set! dp i 0)
          (let ([len j])
            (define k (- i (* 2 len)))
            (if (< k 0)
                (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp-prefix (- i len))) MOD)
                (let ([cmp (compare (- i len) i k (- i len)))])
                  (if (or (< cmp 0) (and (= cmp 0) (<= (vector-ref (vector-ref lcp k) (- i len)) len)))
                      (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp k)) MOD)
                      (vector-set! dp i (modulo (+ (vector-ref dp i) (vector-ref dp-prefix (- i len)) (modulo (- (vector-ref dp-prefix k) (if (> k 0) (vector-ref dp-prefix (sub1 k)) 0)) MOD)) MOD))))))))
    (vector-set! dp-prefix i (modulo (+ (vector-ref dp-prefix (sub1 i)) (vector-ref dp i)) MOD))

  (vector-ref dp n))

(define (compare i1 j1 i2 j2)
  (define len1 (- j1 i1))
  (define len2 (- j2 i2))
  (cond
    [(< len1 len2) -1]
    [(> len1 len2) 1]
    [else
     (let loop ([i i1] [j i2])
       (cond
         [(>= i j1) 0]
         [(char<? (string-ref num i) (string-ref num j)) -1]
         [(char>? (string-ref num i) (string-ref num j)) 1]
         [else (loop (add1 i) (add1 j))]))]))