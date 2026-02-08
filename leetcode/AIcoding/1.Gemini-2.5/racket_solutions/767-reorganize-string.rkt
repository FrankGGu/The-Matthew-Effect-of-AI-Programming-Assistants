#lang racket

(define (reorganize-string s)
  (define n (string-length s))

  (define freq (make-hash))
  (for ([c (in-string s)])
    (hash-update! freq c add1 0))

  (define char-counts-list
    (sort (map (lambda (pair) (cons (cdr pair) (car pair))) (hash->list freq))
          (lambda (a b) (> (car a) (car b)))))

  (when (and (not (empty? char-counts-list))
             (> (car (car char-counts-list)) (ceiling (/ n 2.0))))
    (string ""))

  (define result-chars (make-vector n #\space))
  (define current-idx 0)

  (for-each
   (lambda (count-char-pair)
     (define count (car count-char-pair))
     (define char (cdr count-char-pair))
     (for ([_ (in-range count)])
       (vector-set! result-chars current-idx char)
       (set! current-idx (+ current-idx 2))
       (when (>= current-idx n)
         (set! current-idx 1))))
   char-counts-list)

  (list->string (vector->list result-chars)))