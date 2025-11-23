#lang racket

(define (num-strings s)
  (string-length s))

(define (similar a b)
  (define count 0)
  (for ([i (in-range (num-strings a))])
    (when (not (= (string-ref a i) (string-ref b i)))
      (set! count (+ count 1))
      (when (> count 2)
        (break))))
  (= count 2))

(define (find parent x)
  (if (equal? (vector-ref parent x) x)
      x
      (begin
        (vector-set! parent x (find parent (vector-ref parent x)))
        (vector-ref parent x))))

(define (union parent rank x y)
  (define root-x (find parent x))
  (define root-y (find parent y))
  (when (not (= root-x root-y))
    (if (> (vector-ref rank root-x) (vector-ref rank root-y))
        (vector-set! parent root-y root-x)
        (begin
          (vector-set! parent root-x root-y)
          (when (= (vector-ref rank root-x) (vector-ref rank root-y))
            (vector-set! rank root-y (+ (vector-ref rank root-y) 1)))))))

(define (count-parents parent)
  (define seen (make-hash))
  (for ([i (in-range (vector-length parent))])
    (hash-set! seen (find parent i) #t))
  (hash-count seen))

(define (str-matching-groups strs)
  (define n (length strs))
  (define parent (build-vector n (lambda (i) i)))
  (define rank (build-vector n (lambda (i) 0)))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (when (similar (list-ref strs i) (list-ref strs j))
        (union parent rank i j))))
  (count-parents parent))