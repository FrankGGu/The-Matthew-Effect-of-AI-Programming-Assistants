#lang racket

(define (find-repeated-dna-sequences s)
  (let* ([len (string-length s)]
         [seen (make-hash)]
         [repeated (make-hash)])
    (when (>= len 10)
      (for ([i (in-range 0 (- len 9))])
        (let ([sub (substring s i (+ i 10))])
          (if (hash-has-key? seen sub)
              (hash-set! repeated sub #t)
              (hash-set! seen sub #t)))))
    (hash-keys repeated)))