(define (min-deletion-size A)
  (define rows (length A))
  (define cols (length (car A)))

  (define (solve col deleted)
    (if (= col cols)
        deleted
        (let loop ((i 1)
                   (last-char (list-ref (car A) col))
                   (current-deleted deleted)
                   (valid #t))
          (cond
            ((= i rows)
             (if valid
                 (min (solve (+ col 1) current-deleted)
                      (+ 1 (solve (+ col 1) (+ current-deleted 1))))
                 (+ 1 (solve (+ col 1) (+ current-deleted 1)))))
            (else
             (let ((char (list-ref (list-ref A i) col)))
               (if (<= last-char char)
                   (loop (+ i 1) char current-deleted valid)
                   (loop (+ i 1) last-char (+ current-deleted 1) #f))))))))

  (solve 0 0))