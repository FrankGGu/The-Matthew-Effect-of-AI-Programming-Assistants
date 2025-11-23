#lang racket

(define (largest-number-after-digit-swaps-by-parity nums)
  (define (swap-possible? i j)
    (= (modulo (list-ref nums i) 2) (modulo (list-ref nums j) 2)))

  (define (bubble-sort lst)
    (let loop ([lst lst] [swapped #f])
      (if (not swapped)
          lst
          (loop (reverse (cdr (reverse (foldl (lambda (x acc)
                                              (if (and (not (null? acc))
                                                      (swap-possible? (length acc) (length acc -1)))
                                                  (cons x (car acc))
                                                  (cons x acc)))
                                            '()
                                            lst)))
                #f))))

  (string->number (string-join (map number->string (bubble-sort nums)) "")))