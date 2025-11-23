#lang racket

(define (minimum-operations nums)
  (define n (length nums))

  (when (<= n 1)
    0)

  (define even-freqs (make-hash))
  (define odd-freqs (make-hash))

  (for ([val (in-list nums)]
        [i (in-range n)])
    (if (even? i)
        (hash-update! even-freqs val add1 0)
        (hash-update! odd-freqs val add1 0)))

  (define (get-top-2-freqs freq-hash)
    (define freq-list
      (sort (hash-map freq-hash (lambda (k v) (cons v k)))
            (lambda (a b) (> (car a) (car b)))))

    (match freq-list
      ['() '((0 . -1) (0 . -1))]
      [(list top1) (list top1 '(0 . -1))]
      [(list top1 top2 rest ...) (list top1 top2)]))

  (define even-top-2 (get-top-2-freqs even-freqs))
  (define odd-top-2 (get-top-2-freqs odd-freqs))

  (define even-count1 (car (car even-top-2)))
  (define even-val1 (cdr (car even-top-2)))
  (define even-count2 (car (cadr even-top-2)))
  (define even-val2 (cdr (cadr even-top-2)))

  (define odd-count1 (car (car odd-top-2)))
  (define odd-val1 (cdr (car odd-top-2)))
  (define odd-count2 (car (cadr odd-top-2)))
  (define odd-val2 (cdr (cadr odd-top-2)))

  (define total-even (ceiling (/ n 2)))
  (define total-odd (floor (/ n 2)))

  (if (not (= even-val1 odd-val1))
      (- (+ total-even total-odd) even-count1 odd-count1)
      (min (- (+ total-even total-odd) even-count1 odd-count2)
           (- (+ total-even total-odd) even-count2 odd-count1))))