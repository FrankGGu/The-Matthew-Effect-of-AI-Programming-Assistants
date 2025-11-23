#lang racket
(require data/red-black-tree)
(require racket/vector)

(define (odd-even-jumps arr)
  (define n (vector-length arr))

  (when (zero? n)
    (error 'odd-even-jumps "empty array"))
  (when (= n 1)
    1)

  (define next-odd-jump (make-vector n -1))
  (define next-even-jump (make-vector n -1))

  (define (compare-by-value x y)
    (< (car x) (car y)))

  (define rbt (rbt-set)) ; Stores (value . index) pairs, ordered by value

  (for* ([i (range (- n 1) -1 -1)])
    (define current-val (vector-ref arr i))
    (define current-pair (cons current-val i))

    (define ceiling-pair (rbt-set-ceiling rbt current-val compare-by-value))
    (when (not (void? ceiling-pair))
      (vector-set! next-odd-jump i (cdr ceiling-pair)))

    (define floor-pair (rbt-set-floor rbt current-val compare-by-value))
    (when (not (void? floor-pair))
      (vector-set! next-even-jump i (cdr floor-pair)))

    (set! rbt (rbt-set-add rbt current-pair compare-by-value)))

  (define dp-odd (make-vector n #f))
  (define dp-even (make-vector n #f))

  (vector-set! dp-odd (- n 1) #t)
  (vector-set! dp-even (- n 1) #t)

  (define ans 1)

  (for* ([i (range (- n 2) -1 -1)])
    (define next-odd-idx (vector-ref next-odd-jump i))
    (when (not (= next-odd-idx -1))
      (vector-set! dp-odd i (vector-ref dp-even next-odd-idx)))

    (define next-even-idx (vector-ref next-even-jump i))
    (when (not (= next-even-idx -1))
      (vector-set! dp-even i (vector-ref dp-odd next-even-idx)))

    (when (vector-ref dp-odd i)
      (set! ans (+ ans 1))))

  ans)