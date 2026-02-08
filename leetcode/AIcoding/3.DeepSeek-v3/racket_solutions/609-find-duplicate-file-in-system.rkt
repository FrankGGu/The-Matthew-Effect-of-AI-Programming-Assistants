(define (find-duplicate paths)
  (define content-map (make-hash))
  (for ([path-info paths])
    (let* ([parts (string-split path-info " ")]
           [dir (first parts)]
           [files (rest parts)])
      (for ([file files])
        (let* ([file-parts (string-split file "(")]
               [name (first file-parts)]
               [content (substring (second file-parts) 0 (- (string-length (second file-parts)) 1))])
          (hash-set! content-map 
                     content 
                     (cons (string-append dir "/" name) 
                           (hash-ref content-map content '())))))))
  (filter (λ (x) (> (length x) 1)) (hash-values content-map)))