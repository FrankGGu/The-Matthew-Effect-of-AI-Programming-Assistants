#lang racket

(define (min-cost-for-cutting-cake h w cuts)
  (define (sort-cuts cuts)
    (sort cuts <))

  (define h-cuts (sort-cuts (filter (lambda (x) (= (remainder x w) 0)) cuts)))
  (define v-cuts (sort-cuts (filter (lambda (x) (= (remainder x h) 0)) cuts)))

  (define (get-cost cuts length)
    (let loop ((cuts cuts) (prev 0) (cost 0))
      (if (null? cuts)
          cost
          (let* ((current (car cuts))
                 (segment (- current prev)))
            (loop (cdr cuts) current (+ cost (* segment length)))))))

  (let* ((h-length (add1 (length h-cuts)))
         (v-length (add1 (length v-cuts)))
         (total-cost (+ (get-cost h-cuts w) (get-cost v-cuts h))))
    total-cost))