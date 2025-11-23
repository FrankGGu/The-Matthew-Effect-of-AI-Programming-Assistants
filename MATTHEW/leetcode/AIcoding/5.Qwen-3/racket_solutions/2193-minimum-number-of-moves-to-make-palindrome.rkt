#lang racket

(define (min-moves-to-make-palindrome s)
  (define n (string-length s))
  (define chars (string->list s))
  (define (count-swaps left right)
    (if (>= left right) 0
        (let ((last (index-of chars right)))
          (if (= last right)
              (count-swaps (add1 left) (sub1 right))
              (+ (count-swaps left (sub1 right)) (- right last))))))

  (define (is-even? lst)
    (let loop ((lst lst) (counts '()))
      (if (null? lst)
          (andmap (lambda (x) (even? x)) counts)
          (loop (cdr lst) (cons (count (lambda (c) (equal? c (car lst))) lst) counts)))))

  (define (get-middle-char lst)
    (let loop ((lst lst) (counts '()))
      (if (null? lst)
          (let ((odd (filter (lambda (x) (odd? x)) counts)))
            (if (null? odd) #f (car (filter (lambda (x) (odd? x)) counts))))
          (loop (cdr lst) (cons (count (lambda (c) (equal? c (car lst))) lst) counts)))))

  (define (remove-middle-char lst)
    (let ((mid (get-middle-char lst)))
      (if mid
          (let ((idx (index-of lst mid)))
            (append (take lst idx) (drop lst (add1 idx))))
          lst)))

  (define (make-palindrome lst)
    (let ((mid (get-middle-char lst)))
      (if mid
          (begin
            (set! lst (remove-middle-char lst))
            (let loop ((left 0) (right (sub1 (length lst))) (swaps 0))
              (if (>= left right)
                  swaps
                  (let ((last (index-of lst right)))
                    (if (= last right)
                        (loop (add1 left) (sub1 right) swaps)
                        (loop (add1 left) (sub1 right) (+ swaps (- right last))))))))
          (let loop ((left 0) (right (sub1 (length lst))) (swaps 0))
            (if (>= left right)
                swaps
                (let ((last (index-of lst right)))
                  (if (= last right)
                      (loop (add1 left) (sub1 right) swaps)
                      (loop (add1 left) (sub1 right) (+ swaps (- right last)))))))))

  (make-palindrome chars))