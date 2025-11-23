#lang racket

(define (make-dsu n)
  (define parents (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parents i i))
  parents)

(define (dsu-find parents i)
  (let ([p (vector-ref parents i)])
    (if (= p i)
        i
        (let ([root (dsu-find parents p)])
          (vector-set! parents i root)
          root))))

(define (dsu-union parents i j)
  (let ([root-i (dsu-find parents i)]
        [root-j (dsu-find parents j)])
    (unless (= root-i root-j)
      (vector-set! parents root-j root-i)
      #t)
    #f))

(define (minimize-hamming-distance source target allowedSwaps)
  (define n (length source))
  (define parents (make-dsu n))

  (define source-vec (list->vector source))
  (define target-vec (list->vector target))

  (for ([swap allowedSwaps])
    (define u (car swap))
    (define v (cadr swap))
    (dsu-union parents u v))

  (define components (make-hash))
  (for ([i (in-range n)])
    (define root (dsu-find parents i))
    (hash-update! components root (lambda (lst) (cons i lst)) '()))

  (define total-hamming-distance 0)
  (hash-for-each
   components
   (lambda (root indices-in-component)
     (define source-counts (make-hash))
     (define target-counts (make-hash))

     (for ([idx indices-in-component])
       (hash-update! source-counts (vector-ref source-vec idx) add1 0)
       (hash-update! target-counts (vector-ref target-vec idx) add1 0))

     (define component-matches 0)
     (hash-for-each
      source-counts
      (lambda (val src-count)
        (define tgt-count (hash-ref target-counts val 0))
        (set! component-matches (+ component-matches (min src-count tgt-count)))))

     (define component-size (length indices-in-component))
     (set! total-hamming-distance (+ total-hamming-distance (- component-size component-matches)))))

  total-hamming-distance)