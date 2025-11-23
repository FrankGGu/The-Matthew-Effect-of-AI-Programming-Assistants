#lang racket

(define (count-paths n roads)
  (define mod 1000000007)
  (define adj (make-vector n '()))
  (for ([r roads])
    (let ([u (first r)]
          [v (second r)]
          [t (third r)])
      (vector-set! adj u (cons (cons v t) (vector-ref adj u))
      (vector-set! adj v (cons (cons u t) (vector-ref adj v)))))

  (define dist (make-vector n +inf.0))
  (vector-set! dist 0 0)
  (define ways (make-vector n 0))
  (vector-set! ways 0 1)

  (define heap (make-heap (lambda (a b) (< (car a) (car b)))))
  (heap-add! heap (cons 0 0))

  (let loop ()
    (unless (heap-empty? heap)
      (let* ([current (heap-min heap)]
             [d (car current)]
             [u (cdr current)])
        (heap-remove-min! heap)
        (when (<= d (vector-ref dist u))
          (for ([neighbor (vector-ref adj u)])
            (let ([v (car neighbor)]
                  [t (cdr neighbor)])
              (when (< (+ d t) (vector-ref dist v))
                (vector-set! dist v (+ d t))
                (vector-set! ways v (vector-ref ways u))
                (heap-add! heap (cons (+ d t) v)))
              (when (= (+ d t) (vector-ref dist v))
                (vector-set! ways v 
                             (modulo (+ (vector-ref ways v) 
                                        (vector-ref ways u)) 
                                     mod)))))))
        (loop))))

  (vector-ref ways (- n 1)))