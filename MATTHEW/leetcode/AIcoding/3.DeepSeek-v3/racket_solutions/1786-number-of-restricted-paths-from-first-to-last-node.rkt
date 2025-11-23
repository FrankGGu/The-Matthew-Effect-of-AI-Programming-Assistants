#lang racket

(define (count-restricted-paths n edges)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (sub1 (first edge))]
          [v (sub1 (second edge))]
          [w (third edge)])
      (vector-set! adj u (cons (cons v w) (vector-ref adj u)))
      (vector-set! adj v (cons (cons u w) (vector-ref adj v)))))

  (define dist (make-vector n +inf.0))
  (vector-set! dist (sub1 n) 0)
  (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! heap (cons 0 (sub1 n)))

  (let loop ()
    (when (not (heap-empty? heap))
      (let* ([current (heap-min heap)]
             [d (car current)]
             [u (cdr current)])
        (heap-remove-min! heap)
        (when (<= d (vector-ref dist u))
          (for ([neighbor (vector-ref adj u)])
            (let* ([v (car neighbor)]
                   [w (cdr neighbor)]
                   [new-dist (+ d w)])
              (when (< new-dist (vector-ref dist v))
                (vector-set! dist v new-dist)
                (heap-add! heap (cons new-dist v))))))
        (loop))))

  (define dp (make-vector n -1))
  (define (dfs u)
    (cond [(= u (sub1 n)) 1]
          [(not (= (vector-ref dp u) -1)) (vector-ref dp u)]
          [else
           (let ([res 0])
             (for ([neighbor (vector-ref adj u)])
               (let ([v (car neighbor)])
                 (when (< (vector-ref dist v) (vector-ref dist u))
                   (set! res (modulo (+ res (dfs v)) 1000000007)))))
             (vector-set! dp u res)
             res)]))

  (dfs 0))

(define-struct heap (cmp vec size))

(define (make-heap cmp)
  (heap cmp (make-vector 16 #f) 0))

(define (heap-add! h x)
  (define vec (heap-vec h))
  (define size (heap-size h))
  (when (= size (vector-length vec))
    (let ([new-vec (make-vector (* 2 (vector-length vec))])
      (vector-copy! new-vec 0 vec)
      (set-heap-vec! h new-vec)))
  (vector-set! vec size x)
  (set-heap-size! h (add1 size))
  (sift-up h (sub1 (heap-size h))))

(define (heap-min h)
  (vector-ref (heap-vec h) 0))

(define (heap-remove-min! h)
  (define vec (heap-vec h))
  (define size (heap-size h))
  (vector-set! vec 0 (vector-ref vec (sub1 size)))
  (set-heap-size! h (sub1 size))
  (sift-down h 0))

(define (heap-empty? h)
  (= (heap-size h) 0))

(define (sift-up h i)
  (define vec (heap-vec h))
  (define cmp (heap-cmp h))
  (let loop ([i i])
    (when (> i 0)
      (let ([parent (quotient (sub1 i) 2)])
        (when (cmp (vector-ref vec i) (vector-ref vec parent))
          (let ([tmp (vector-ref vec i)])
            (vector-set! vec i (vector-ref vec parent))
            (vector-set! vec parent tmp)
            (loop parent)))))))

(define (sift-down h i)
  (define vec (heap-vec h))
  (define cmp (heap-cmp h))
  (define size (heap-size h))
  (let loop ([i i])
    (let* ([left (+ (* 2 i) 1)]
           [right (+ (* 2 i) 2)]
           [smallest i])
      (when (and (< left size) (cmp (vector-ref vec left) (vector-ref vec smallest)))
        (set! smallest left))
      (when (and (< right size) (cmp (vector-ref vec right) (vector-ref vec smallest)))
        (set! smallest right))
      (when (not (= smallest i))
        (let ([tmp (vector-ref vec i)])
          (vector-set! vec i (vector-ref vec smallest))
          (vector-set! vec smallest tmp)
          (loop smallest))))))