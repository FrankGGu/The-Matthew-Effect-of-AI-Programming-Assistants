#lang racket

(require data/set)

(define (count-rings rings)
  (define rod-colors (make-hash))

  (for ([i (in-range 0 (string-length rings) 2)])
    (define color (string-ref rings i))
    (define rod-char (string-ref rings (+ i 1)))
    (define rod-id (- (char->integer rod-char) (char->integer #\0)))

    (define current-colors (hash-ref rod-colors rod-id (set)))
    (hash-set! rod-colors rod-id (set-add current-colors color)))

  (define full-rods 0)
  (hash-for-each
   rod-colors
   (lambda (rod-id colors-set)
     (when (= (set-count colors-set) 3)
       (set! full-rods (+ full-rods 1)))))
  full-rods)