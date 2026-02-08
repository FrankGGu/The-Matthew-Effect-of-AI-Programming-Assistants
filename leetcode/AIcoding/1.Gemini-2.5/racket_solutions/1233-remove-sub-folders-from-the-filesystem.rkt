(define (remove-subfolders folders)
  (define sorted-folders (sort folders string<?))

  (define (loop remaining-folders result-acc)
    (cond
      [(empty? remaining-folders)
       (reverse result-acc)]
      [else
       (define current-folder (first remaining-folders))
       (if (empty? result-acc)
           (loop (rest remaining-folders) (list current-folder))
           (define last-root-folder (first result-acc))
           (if (string-prefix? (string-append last-root-folder "/") current-folder)
               (loop (rest remaining-folders) result-acc)
               (loop (rest remaining-folders) (cons current-folder result-acc))))]))

  (loop sorted-folders '()))