#lang racket

(define (ways-to-cut-pizza pizza k)
  (define R (vector-length pizza))
  (define C (vector-length (vector-ref pizza 0)))
  (define MOD 1000000007)

  (define apples (make-vector R (lambda () (make-vector C 0))))

  (for* ([r (range (- R 1) -1 -1)]
         [c (range (- C 1) -1 -1)])
    (define current-cell-has-apple (if (char=? (string-ref (vector-ref pizza r) c) #\A) 1 0))
    (define apples-right (if (< (+ c 1) C) (vector-ref (vector-ref apples r) (+ c 1)) 0))
    (define apples-down (if (< (+ r 1) R) (vector-ref (vector-ref apples (+ r 1)) c) 0))
    (define apples-down-right (if (and (< (+ r 1) R) (< (+ c 1) C)) (vector-ref (vector-ref apples (+ r 1)) (+ c 1)) 0))
    (vector-set! (vector-ref apples r) c
                 (+ current-cell-has-apple apples-right apples-down (- apples-down-right))))

  (define dp (make-vector k (lambda () (make-vector R (lambda () (make-vector C 0))))))

  (for* ([r (range R)]
         [c (range C)])
    (when (> (vector-ref (vector-ref apples r) c) 0)
      (vector-set! (vector-ref (vector-ref (vector-ref dp 0) r) c) 1)))

  (for ([num-pieces-idx (range 1 k)])
    (for* ([r (range R)]
           [c (range C)])
      (define current-ways 0)
      (when (> (vector-ref (vector-ref apples r) c) 0)
        (for ([nr (range (+ r 1) R)])
          (define apples-in-top-piece (- (vector-ref (vector-ref apples r) c) (vector-ref (vector-ref apples nr) c)))
          (when (> apples-in-top-piece 0)
            (set! current-ways (modulo (+ current-ways (vector-ref (vector-ref (vector-ref dp (- num-pieces-idx 1)) nr) c)) MOD))))

        (for ([nc (range (+ c 1) C)])
          (define apples-in-left-piece (- (vector-ref (vector-ref apples r) c) (vector-ref (vector-ref apples r) nc)))
          (when (> apples-in-left-piece 0)
            (set! current-ways (modulo (+ current-ways (vector-ref (vector-ref (vector-ref dp (- num-pieces-idx 1)) r) nc)) MOD))))
        )
      (vector-set! (vector-ref (vector-ref (vector-ref dp num-pieces-idx) r) c) current-ways)
      ))

  (vector-ref (vector-ref (vector-ref dp (- k 1)) 0) 0))