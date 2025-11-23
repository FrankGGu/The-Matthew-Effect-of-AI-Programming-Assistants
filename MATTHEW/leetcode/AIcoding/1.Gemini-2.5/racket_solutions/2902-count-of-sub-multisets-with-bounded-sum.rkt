#lang racket

(require data/deque)

(define (count-sub-multisets-with-bounded-sum nums l r)
  (define MOD 1000000007)

  (define counts (make-hash))
  (for-each (lambda (n)
              (hash-set! counts n (+ (hash-ref counts n 0) 1)))
            nums)

  (define dp (make-vector (+ r 1) 0))
  (vector-set! dp 0 1)

  (hash-for-each
   (lambda (num count)
     (if (= num 0)
         (for i (in-range (+ r 1))
           (vector-set! dp i (modulo (* (vector-ref dp i) (+ count 1)) MOD)))
         (begin
           (for rem (in-range num)
             (when (<= rem r)
               (define current-sum 0)
               (define q (make-deque))

               (for k (in-range (quotient (- r rem) num) (+ 1))
                 (define idx (+ rem (* k num)))

                 (set! current-sum (modulo (+ current-sum (vector-ref dp idx)) MOD))
                 (deque-push-back! q (vector-ref dp idx))

                 (when (> k count)
                   (define old-val (deque-pop-front! q))
                   (set! current-sum (modulo (- current-sum old-val) MOD))
                   (when (< current-sum 0) (set! current-sum (+ current-sum MOD))))

                 (vector-set! dp idx current-sum)))))))
   counts)

  (define total-count 0)
  (for i (in-range l (+ r 1))
    (set! total-count (modulo (+ total-count (vector-ref dp i)) MOD)))

  total-count)