#lang racket

(require racket/string)

(define (remove-occurrences s part)
  (let loop ((current-s s))
    (define-values (found-idx) (string-find current-s part))
    (if found-idx
        (let* ((len-part (string-length part))
               (before (substring current-s 0 found-idx))
               (after (substring current-s (+ found-idx len-part))))
          (loop (string-append before after)))
        current-s)))