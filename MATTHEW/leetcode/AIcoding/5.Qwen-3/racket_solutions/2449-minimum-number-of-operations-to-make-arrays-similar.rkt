#lang racket

(define (min-operations nums target)
  (define (count-odd-even lst)
    (let loop ([lst lst] [odds 0] [evens 0])
      (if (null? lst)
          (cons odds evens)
          (loop (cdr lst)
                (if (odd? (car lst)) (+ odds 1) odds)
                (if (even? (car lst)) (+ evens 1) evens)))))

  (define (get-odds-evens lst)
    (let* ([cnt (count-odd-even lst)]
           [odds (car cnt)]
           [evens (cdr cnt)])
      (list odds evens)))

  (define (get-ops a b)
    (let ([a-odds (caar a)]
          [a-evens (cdar a)]
          [b-odds (caar b)]
          [b-evens (cdar b)])
      (abs (- a-odds b-odds))))

  (define (get-odds-evens-list lst)
    (map get-odds-evens lst))

  (define (get-odds-evens-counts lst)
    (let ([odds (map (lambda (x) (car x)) lst)]
          [evens (map (lambda (x) (cdr x)) lst)])
      (list (apply + odds) (apply + evens))))

  (define (get-odds-evens-diff a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (abs (- a-odds b-odds)) (abs (- a-evens b-evens))))

  (define (get-odds-evens-diffs a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sum a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (+ (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-list a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get-odds-evens-sums-lists a b)
    (let ([a-odds (car a)]
          [a-evens (cadr a)]
          [b-odds (car b)]
          [b-evens (cadr b)])
      (list (abs (- a-odds b-odds)) (abs (- a-evens b-evens)))))

  (define (get