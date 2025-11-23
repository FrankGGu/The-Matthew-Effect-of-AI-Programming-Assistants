#lang racket

(define (find-all-concatenated-words-in-a-dict words)
  (define word-set (list->set words))
  (define (can-form? word)
    (let loop ([i 1])
      (cond
        [(>= i (string-length word)) #f]
        [else
         (let ([prefix (substring word 0 i)]
               [suffix (substring word i)])
           (if (and (set-member? word-set prefix)
                   (or (set-member? word-set suffix)
                       (can-form? suffix)))
               #t
               (loop (add1 i))))])))
  (filter (lambda (word) (and (not (equal? word "")) (can-form? word))) words))