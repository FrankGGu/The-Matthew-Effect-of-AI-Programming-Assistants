(define (delete-duplicate-folders paths)
  (define (dfs path)
    (let* ((folder (car path))
           (subfolders (map dfs (cdr path)))
           (subfolder-structure (sort subfolders string<?)))
      (if (equal? (hash-ref folder-map subfolder-structure '()) '())
          (begin
            (hash-set! folder-map subfolder-structure (cons folder '()))
            (cons folder subfolder-structure))
          '())))

  (define folder-map (make-hash))
  (map dfs paths)
  (hash->list folder-map))