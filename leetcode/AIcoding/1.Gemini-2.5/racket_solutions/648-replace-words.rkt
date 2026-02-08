#lang racket

(require srfi/1)   ; For list-processing functions like sort, map
(require srfi/13)  ; For string-prefix?
(require racket/string) ; For string-split, string-join

(define (replace-words dictionary sentence)
  (let* ((sorted-dictionary (sort dictionary (lambda (a b) (< (string-length a) (string-length b)))))
         (words (string-split sentence " ")))
    (define (find-and-replace word)
      (let loop ((roots sorted-dictionary))
        (cond
          ((null? roots) word)
          ((string-prefix? (car roots) word) (car roots))
          (else (loop (cdr roots))))))
    (string-join (map find-and-replace words) " ")))