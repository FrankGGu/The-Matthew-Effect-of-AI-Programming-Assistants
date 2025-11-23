#lang racket

(define (find-duplicate-file-in-system paths)
  (define content-map (make-hash))

  (for-each (lambda (path-str)
              (define parts (string-split path-str " "))
              (define directory (car parts))
              (define files (cdr parts))

              (for-each (lambda (file-info)
                          (define open-paren-idx (string-index file-info #\( ))
                          (define close-paren-idx (string-index file-info #\) ))

                          (define file-name (substring file-info 0 open-paren-idx))
                          (define content (substring file-info (add1 open-paren-idx) close-paren-idx))

                          (define full-path (string-append directory "/" file-name))

                          (hash-set! content-map
                                     content
                                     (cons full-path (hash-ref content-map content '()))))
                        files))
            paths)

  (define result '())
  (for-each (lambda (paths-list)
              (when (> (length paths-list) 1)
                (set! result (cons paths-list result))))
            (hash-values content-map))
  result)