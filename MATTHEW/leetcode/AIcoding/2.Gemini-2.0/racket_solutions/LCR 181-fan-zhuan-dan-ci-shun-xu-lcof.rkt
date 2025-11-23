(define (reverse-words s)
  (let* ([words (string-split (string-trim s) " ")]
         [filtered-words (filter (lambda (word) (not (equal? word ""))) words)]
         [reversed-words (reverse filtered-words)])
    (string-join reversed-words " ")))