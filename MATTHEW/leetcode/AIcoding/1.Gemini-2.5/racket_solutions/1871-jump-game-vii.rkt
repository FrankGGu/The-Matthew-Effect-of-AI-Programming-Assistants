#lang racket

(require data/deque)

(define (can-reach-end s minJump maxJump)
  (define n (string-length s))
  (define dp (make-vector n #f))
  (vector-set! dp 0 #t)

  (define q (make-deque))
  (deque-push-back! q 0)

  (for ([i (in-range 1 n)])
    (when (= (char->integer (string-ref s i)) (char->integer #\0))
      (while (and (not (deque-empty? q))
                  (< (deque-front q) (- i maxJump)))
        (deque-pop-front! q))

      (when (and (not (deque-empty? q))
                 (<= (deque-front q) (- i minJump)))
        (vector-set! dp i #t)
        (deque-push-back! q i))))

  (vector-ref dp (- n 1)))