#lang racket

(define (find-duplicate-file-in-system paths)
  (define content-to-paths (make-hash))

  (for-each (lambda (path-str)
              (define parts (string-split path-str " "))
              (define dir (first parts))
              (define files (rest parts))

              (for-each (lambda (file-info)
                          (define open-paren-idx (string-index file-info #\())
                          (define filename (substring file-info 0 open-paren-idx))
                          (define content (substring file-info (+ open-paren-idx 1) (- (string-length file-info) 1)))
                          (define full-path (string-append dir "/" filename))

                          (hash-set! content-to-paths
                                     content
                                     (cons full-path (hash-ref content-to-paths content '()))))
                        files))
            paths)

  (define result '())
  (hash-for-each (lambda (content path-list)
                   (when (> (length path-list) 1)
                     (set! result (cons path-list result))))
                 content-to-paths)
  result)