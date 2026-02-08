(define (remove-subfolders folder)
  (define (is-subfolder? parent child)
    (and (string-starts-with? child (string-append parent "/"))
         (not (= (string-length child) (+ (string-length parent) 1)))))

  (define (filter-folders folders)
    (foldl (lambda (current acc)
              (if (any (lambda (x) (is-subfolder? current x)) acc)
                  acc
                  (cons current acc)))
            '()
            (reverse folders)))

  (filter-folders (sort folder string<?)))