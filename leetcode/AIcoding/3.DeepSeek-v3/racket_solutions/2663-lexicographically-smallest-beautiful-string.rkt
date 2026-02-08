#lang racket

(define (smallestBeautifulString s k)
  (define n (string-length s))
  (define s-list (string->list s))
  (define (valid? lst i c)
    (and (or (< i 1) (not (char=? c (list-ref lst (- i 1)))))
         (or (< i 2) (not (char=? c (list-ref lst (- i 2)))))))
  (define (find-next lst i)
    (let loop ([c (integer->char (+ (char->integer (list-ref lst i)) 1))])
      (if (char>? c (integer->char (+ (char->integer #\a) (- k 1))))
          #f
          (if (valid? lst i c)
              c
              (loop (integer->char (+ (char->integer c) 1)))))))
  (define (backtrack lst i)
    (cond
      [(= i n) (list->string lst)]
      [else
       (let ([next (find-next lst i)])
         (if next
             (let ([new-lst (list-set lst i next)])
               (let ([res (backtrack new-lst (+ i 1))])
                 (if res res (backtrack lst (- i 1)))))
             (if (= i 0)
                 ""
                 (let ([prev (list-ref lst (- i 1))])
                   (let ([new-c (integer->char (+ (char->integer prev) 1))])
                     (if (char>? new-c (integer->char (+ (char->integer #\a) (- k 1)))))
                         (backtrack lst (- i 1))
                         (if (valid? lst i new-c)
                             (let ([new-lst (list-set lst i new-c)])
                               (backtrack new-lst (+ i 1)))
                             (backtrack lst (- i 1)))))))))]))
  (define result (backtrack s-list 0))
  (if (string=? result "") "" result))