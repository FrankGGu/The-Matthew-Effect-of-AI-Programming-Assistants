#lang racket

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (find-parent x parent)
  (if (= (vector-ref parent x) x)
      x
      (let ([p (find-parent (vector-ref parent x) parent)])
        (vector-set! parent x p)
        p)))

(define (union x y parent rank)
  (let ([xroot (find-parent x parent)]
        [yroot (find-parent y parent)])
    (when (not (= xroot yroot))
      (if (< (vector-ref rank xroot) (vector-ref rank yroot))
          (vector-set! parent xroot yroot)
          (begin
            (vector-set! parent yroot xroot)
            (when (= (vector-ref rank xroot) (vector-ref rank yroot))
              (vector-set! rank xroot (+ (vector-ref rank xroot) 1))))))))

(define (can-be-sorted nums)
  (define n (length nums))
  (define max-num (apply max nums))
  (define parent (make-vector (+ max-num 1) 0))
  (define rank (make-vector (+ max-num 1) 1))
  (for ([i (in-range (+ max-num 1))])
    (vector-set! parent i i))
  (for ([i (in-range 2 (+ max-num 1))])
    (for ([j (in-range i (+ max-num 1) i)])
      (union i j parent rank)))
  (define (is-connected x y)
    (= (find-parent x parent) (find-parent y parent)))
  (define sorted-nums (sort nums <))
  (for ([i (in-range n)])
    (if (not (is-connected (list-ref nums i) (list-ref sorted-nums i)))
        #f
        #t))
  (andmap identity (for/list ([i (in-range n)]) (is-connected (list-ref nums i) (list-ref sorted-nums i)))))

(define/contract (can_sort_array nums)
  (-> (listof exact-integer?) boolean?)
  (can-be-sorted nums))