#lang racket

(define (min-hamming-distance n sources targets)
  (define (find-parent x)
    (if (equal? (vector-ref parent x) x)
        x
        (let ((p (find-parent (vector-ref parent x))))
          (vector-set! parent x p)
          p)))

  (define (union x y)
    (let ((px (find-parent x))
          (py (find-parent y)))
      (when (not (equal? px py))
        (vector-set! parent py px))))

  (define parent (make-vector n))
  (for ([i (in-range n)])
    (vector-set! parent i i))

  (for ([i (in-range n)]
        [s sources])
    (when (not (= s i))
      (union i s)))

  (define (get-group x)
    (let ((p (find-parent x)))
      (let loop ([i 0] [groups '()])
        (if (= i n)
            groups
            (if (= (find-parent i) p)
                (loop (+ i 1) (cons i groups))
                (loop (+ i 1) groups)))))

  (define groups (for/list ([i (in-range n)])
                   (get-group i)))

  (define (count-matches group)
    (let ((s-count (make-hash))
          (t-count (make-hash)))
      (for-each (lambda (i) (hash-update! s-count (list-ref sources i) add1 0)) group)
      (for-each (lambda (i) (hash-update! t-count (list-ref targets i) add1 0)) group)
      (for/sum ([k (hash-keys s-count)])
        (min (hash-ref s-count k 0) (hash-ref t-count k 0)))))

  (apply + (map count-matches groups)))