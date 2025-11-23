#lang racket

(define (are-connected a b)
  (define diff (string-length a))
  (for/and ([i (in-range (string-length a))])
    (if (= (string-ref a i) (string-ref b i))
        #t
        (begin
          (set! diff (- diff 1))
          (if (= diff 0) #f #t))))
  (>= diff 0))

(define (find-roots parent x)
  (if (equal? (vector-ref parent x) x)
      x
      (let ([root (find-roots parent (vector-ref parent x))])
        (vector-set! parent x root)
        root)))

(define (union parent x y)
  (let ([x-root (find-roots parent x)]
        [y-root (find-roots parent y)])
    (when (not (equal? x-root y-root))
      (vector-set! parent y-root x-root))))

(define (count-components strings)
  (define n (length strings))
  (define parent (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! parent i i))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (when (are-connected (list-ref strings i) (list-ref strings j))
        (union parent i j))))
  (define roots (for/set ([i (in-range n)]) (find-roots parent i)))
  (set-count roots))

(define (main)
  (define input (read-line))
  (define strings (map (lambda (s) (substring s 1 (- (string-length s) 1))) (string-split input #\,)))
  (display (count-components strings)))

(main)