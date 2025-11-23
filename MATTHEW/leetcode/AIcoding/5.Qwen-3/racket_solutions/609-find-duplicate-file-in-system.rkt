#lang racket

(define (find-duplicate paths)
  (define (split-path path)
    (let* ([parts (string-split path #\/)]
           [filename (last parts)]
           [content (string-trim (cadr (string-split filename #\()))])
      (values (car parts) content)))

  (define file-map (make-hash))

  (for-each
   (lambda (path)
     (let-values ([(dir content) (split-path path)])
       (hash-update! file-map content (lambda (lst) (cons dir lst)) '())))
   paths)

  (filter (lambda (lst) (> (length lst) 1))
          (hash-values file-map)))