(define (next-greatest-letter letters target)
  (let loop ((lst letters))
    (if (empty? lst)
        (car letters)
        (let ((current-letter (car lst)))
          (if (char>? current-letter target)
              current-letter
              (loop (cdr lst)))))))