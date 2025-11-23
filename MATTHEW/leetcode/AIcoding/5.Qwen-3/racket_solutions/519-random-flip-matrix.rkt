#lang racket

(define (make-random-flip-matrix n_rows n_cols)
  (let ([total (* n_rows n_cols)]
        [used (hash)]
        [rand (random-generator)])
    (lambda ()
      (let loop ()
        (let ([index (random-integer total rand)])
          (if (hash-has-key? used index)
              (loop)
              (begin
                (hash-set! used index #t)
                (vector (quotient index n_cols) (modulo index n_cols))))))))

(define (main)
  (let ([n_rows (string->number (read-line))]
        [n_cols (string->number (read-line))])
    (let ([obj (make-random-flip-matrix n_rows n_cols)])
      (let loop ([i 0])
        (when (< i 10)
          (displayln (obj))
          (loop (+ i 1)))))))

(main)