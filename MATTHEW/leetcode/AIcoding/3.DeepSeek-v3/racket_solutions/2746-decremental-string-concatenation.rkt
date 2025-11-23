#lang racket

(define (minimize-concatenation-cost words)
  (define n (length words))
  (define memo (make-hash))

  (define (dp first last)
    (define key (cons first last))
    (hash-ref! memo key
               (lambda ()
                 (let loop ([i 0] [cost 0] [first first] [last last])
                   (if (= i n)
                       0
                       (let* ([word (list-ref words i)]
                              [len (string-length word)]
                              [first-char (if (= len 0) #f (string-ref word 0))]
                              [last-char (if (= len 0) #f (string-ref word (sub1 len)))]
                              [cost1 (if (and last first-char (char=? last first-char)) 1 0)]
                              [new-first1 (if first first first-char)]
                              [new-last1 (if last-char last-char last)]
                              [res1 (+ cost1 (dp new-first1 new-last1))]
                              [cost2 (if (and first last-char (char=? first last-char)) 1 0)]
                              [new-first2 (if last-char last-char first)]
                              [new-last2 (if first-char first-char last)]
                              [res2 (+ cost2 (dp new-first2 new-last2))])
                         (min res1 res2)))))))

  (dp #f #f))