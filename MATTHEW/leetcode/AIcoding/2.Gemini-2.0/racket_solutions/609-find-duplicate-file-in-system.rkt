(define (find-duplicate paths)
  (define file-map (make-hash))
  (for-each
   (lambda (path-str)
     (let* ([parts (string-split path-str " ")]
            [dir (car parts)]
            [files (cdr parts)])
       (for-each
        (lambda (file-str)
          (let* ([open-paren-index (string-index file-str "(")]
                 [close-paren-index (string-index file-str ")")]
                 [file-name (substring file-str 0 open-paren-index)]
                 [content (substring file-str (+ 1 open-paren-index) close-paren-index)]
                 [full-path (string-append dir "/" file-name)])
            (hash-update! file-map content (lambda (v) (append v (list full-path))) '())))
        files)))
   paths)

  (filter (lambda (x) (> (length x) 1)) (hash-values file-map)))