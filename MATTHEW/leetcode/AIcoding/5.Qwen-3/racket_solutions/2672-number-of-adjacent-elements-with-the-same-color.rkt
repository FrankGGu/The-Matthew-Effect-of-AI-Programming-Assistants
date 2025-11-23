#lang racket

(define (color-segments n colors)
  (define (helper i res)
    (if (= i n)
        res
        (let ([current (list-ref colors i)])
          (if (and (> i 0) (= current (list-ref colors (- i 1))))
              (helper (+ i 1) res)
              (helper (+ i 1) (cons current res))))))
  (reverse (helper 0 '())))

(define (count-adjacent-elements n colors)
  (define segments (color-segments n colors))
  (define (count-segs segs res)
    (if (null? segs)
        res
        (count-segs (cdr segs) (+ res (if (and (not (null? (cdr segs))) (= (car segs) (cadr segs))) 1 0)))))
  (count-segs segments 0))

(define (main)
  (define n (string->number (read-line)))
  (define colors (map string->number (string-split (read-line))))
  (display (count-adjacent-elements n colors)))

(main)