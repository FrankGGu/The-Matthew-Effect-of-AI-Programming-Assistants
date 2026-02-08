#lang racket

(define (min-flips mat)
  (define m (length mat))
  (define n (length (car mat)))
  (define target (make-list m (make-list n 0)))

  (define (flip mat i j)
    (define (toggle x) (if (= x 0) 1 0))
    (define (update-row row j)
      (for/list ([val (in-list row)] [k (in-range n)])
        (if (= k j) (toggle val) val)))
    (for/list ([row (in-list mat)] [k (in-range m)])
      (if (or (= k i) (and (= (abs (- k i)) 1) (= j (if (> k i) (sub1 j) (add1 j)))))
          (update-row row j)
          row)))

  (define (mat->key mat)
    (for/fold ([key 0]) ([row (in-list mat)] [i (in-range m)])
      (for/fold ([key key]) ([val (in-list row)] [j (in-range n)])
        (+ (arithmetic-shift key 1) val))))

  (let loop ([queue (list (list mat 0))] [visited (set (mat->key mat))])
    (if (null? queue)
        -1
        (let* ([current (car queue)]
               [current-mat (car current)]
               [steps (cadr current)]
               [rest-queue (cdr queue)])
          (if (equal? current-mat target)
              steps
              (let ([new-queue rest-queue])
                (for ([i (in-range m)])
                  (for ([j (in-range n)])
                    (let* ([new-mat (flip current-mat i j)]
                           [new-key (mat->key new-mat)])
                      (unless (set-member? visited new-key)
                        (set! visited (set-add visited new-key))
                        (set! new-queue (append new-queue (list (list new-mat (add1 steps))))))))
                (loop new-queue visited)))))))