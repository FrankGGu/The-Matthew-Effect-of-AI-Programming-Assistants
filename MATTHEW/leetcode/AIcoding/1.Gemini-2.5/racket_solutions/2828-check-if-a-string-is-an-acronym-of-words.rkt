(define (is-acronym words s)
  (let* ((first-letters-chars
          (map (lambda (word) (string-ref word 0)) words))
         (generated-acronym
          (list->string first-letters-chars)))
    (string=? generated-acronym s)))