(define (reverse-words s)
  (let* ([trimmed-s (string-trim s)]
         [words (string-split trimmed-s " ")]
         [filtered-words (filter (lambda (w) (not (string=? w ""))) words)]
         [reversed-words (reverse filtered-words)])
    (string-join reversed-words " ")))