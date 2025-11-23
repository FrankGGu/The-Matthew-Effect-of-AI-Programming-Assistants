#lang racket

(define (vowel? c)
  (member c '(#\a #\e #\i #\o #\u)))

(define (count-vowel-string s)
  (define len (string-length s))
  (define (iter i res)
    (if (= i len)
        res
        (iter (+ i 1) (+ res (if (vowel? (string-ref s i)) 1 0)))))
  (iter 0 0))

(define (vowel-strings-in-ranges word-pairs)
  (define (helper pair)
    (let* ([s (car pair)]
           [l (cadr pair)]
           [r (caddr pair)])
      (define len (string-length s))
      (define (iter i res)
        (if (> i r)
            res
            (iter (+ i 1) (+ res (if (vowel? (string-ref s i)) 1 0)))))
      (iter l 0)))
  (map helper word-pairs))