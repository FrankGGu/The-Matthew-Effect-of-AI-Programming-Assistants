#lang racket

(define (uniqueMiddleMode nums)
  (define (count-modes seq)
    (define counts (make-hash))
    (for ([x seq])
      (hash-set! counts x (+ 1 (hash-ref counts x 0))))
    (define max-count (apply max (hash-values counts)))
    (define modes (filter (lambda (k) (= (hash-ref counts k) max-count)) (hash-keys counts)))
    (if (= (length modes) 1)
        (first modes)
        #f))

  (define (subseqs lst)
    (define (iter l acc)
      (if (null? l)
          (list acc)
          (append (iter (cdr l) acc) (iter (cdr l) (cons (car l) acc)))))
    (iter lst '()))

  (define all-subs (subseqs nums))
  (define valid-subs (filter (lambda (s) (> (length s) 2)) all-subs))
  (define modes (map count-modes valid-subs))
  (define unique-modes (filter (lambda (m) m) modes))
  (length unique-modes))

(uniqueMiddleMode '(1 2 2 3 3 3 4 4 4 5))