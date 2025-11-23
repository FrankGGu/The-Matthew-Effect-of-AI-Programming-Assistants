#lang racket

(define (can-make-palindrome-queries s queries)
  (define n (string-length s))
  (define prefix (make-vector (+ n 1) (make-hash)))
  (for ([i (in-range n)])
    (define prev (vector-ref prefix i))
    (define curr (hash-copy prev))
    (define c (string-ref s i))
    (hash-update! curr c add1 (lambda () 0))
    (vector-set! prefix (+ i 1) curr))

  (define (query-count l r)
    (define end (vector-ref prefix (+ r 1)))
    (define start (vector-ref prefix l))
    (define res (make-hash))
    (for ([(k v) (in-hash end)])
      (define diff (- v (hash-ref start k 0)))
      (when (> diff 0)
        (hash-set! res k diff)))
    res)

  (define (is-palindrome l r)
    (let loop ([i l] [j r])
      (cond
        [(>= i j) #t]
        [(char=? (string-ref s i) (string-ref s j)) (loop (+ i 1) (- j 1))]
        [else #f])))

  (define (solve-query a b c d)
    (define left (query-count 0 (- a 1)))
    (define middle1 (query-count a b))
    (define middle2 (query-count c d))
    (define right (query-count (+ d 1) (- n 1)))

    (define combined (make-hash))
    (for ([(k v) (in-hash left)])
      (hash-update! combined k (lambda (x) (+ x v)) (lambda () 0)))
    (for ([(k v) (in-hash middle2)])
      (hash-update! combined k (lambda (x) (+ x v)) (lambda () 0)))
    (for ([(k v) (in-hash right)])
      (hash-update! combined k (lambda (x) (+ x v)) (lambda () 0)))

    (define combined2 (make-hash))
    (for ([(k v) (in-hash combined)])
      (hash-update! combined2 k (lambda (x) (+ x v)) (lambda () 0)))
    (for ([(k v) (in-hash middle1)])
      (hash-update! combined2 k (lambda (x) (+ x v)) (lambda () 0)))

    (define odd 0)
    (for ([(k v) (in-hash combined2)])
      (when (odd? v) (set! odd (+ odd 1))))
    (<= odd 1))

  (define res '())
  (for ([q (in-list queries)])
    (define a (first q))
    (define b (second q))
    (define c (third q))
    (define d (fourth q))
    (if (is-palindrome a d)
        (set! res (cons #t res))
        (set! res (cons (solve-query a b c d) res))))
  (reverse res))