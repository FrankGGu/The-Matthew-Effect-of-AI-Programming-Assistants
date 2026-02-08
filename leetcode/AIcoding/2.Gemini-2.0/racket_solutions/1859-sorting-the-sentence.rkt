(define (sort-sentence s)
  (string-join
   (map car
        (sort (map (lambda (word)
                      (cons (substring word 0 (- (string-length word) 1))
                            (string->number (substring word (- (string-length word) 1))))
                    )
                  (string-split s))
              (lambda (x y) (< (cdr x) (cdr y)))))
   " "))