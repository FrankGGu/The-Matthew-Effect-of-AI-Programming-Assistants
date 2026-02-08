#lang racket

(define (minimum-score nums edges)
  (define n (vector-length nums))
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v))))

  (define total-xor (for/fold ([res 0]) ([num nums]) (bitwise-xor res num)))

  (define parent (make-vector n -1))
  (define xor-subtree (make-vector n 0))
  (define in-time (make-vector n 0))
  (define out-time (make-vector n 0))
  (define time 0)

  (define (dfs u p)
    (vector-set! parent u p)
    (vector-set! in-time u time)
    (set! time (+ time 1))
    (vector-set! xor-subtree u (vector-ref nums u))
    (for ([v (vector-ref adj u)])
      (when (not (= v p))
        (dfs v u)
        (vector-set! xor-subtree u (bitwise-xor (vector-ref xor-subtree u) (vector-ref xor-subtree v)))))
    (vector-set! out-time u time)
    (set! time (+ time 1)))

  (dfs 0 -1)

  (define min-score +inf.0)
  (for* ([i (in-range 1 n)]
         [j (in-range (+ i 1) n)])
    (let ([a i] [b j])
      (define (is-ancestor? u v)
        (and (<= (vector-ref in-time u) (vector-ref in-time v))
             (>= (vector-ref out-time u) (vector-ref out-time v))))
      (cond
        [(is-ancestor? a b)
         (let ([x (vector-ref xor-subtree b)]
               [y (bitwise-xor (vector-ref xor-subtree a) (vector-ref xor-subtree b))]
               [z (bitwise-xor total-xor (vector-ref xor-subtree a))])
           (set! min-score (min min-score (max x y z) (- (max x y z) (min x y z)))))]
        [(is-ancestor? b a)
         (let ([x (vector-ref xor-subtree a)]
               [y (bitwise-xor (vector-ref xor-subtree b) (vector-ref xor-subtree a)]
               [z (bitwise-xor total-xor (vector-ref xor-subtree b))])
           (set! min-score (min min-score (max x y z) (- (max x y z) (min x y z)))))]
        [else
         (let ([x (vector-ref xor-subtree a)]
               [y (vector-ref xor-subtree b)]
               [z (bitwise-xor total-xor x y)])
           (set! min-score (min min-score (max x y z) (- (max x y z) (min x y z))))]))))

  min-score)