(define (is-path-crossing path)
  (let loop ((current-x 0)
             (current-y 0)
             (visited (set (cons 0 0)))
             (chars (string->list path)))
    (if (empty? chars)
        #f
        (let* ((char (car chars))
               (next-x (case char
                         ((#\E) (+ current-x 1))
                         ((#\W) (- current-x 1))
                         (else current-x)))
               (next-y (case char
                         ((#\N) (+ current-y 1))
                         ((#\S) (- current-y 1))
                         (else current-y))))

          (let ((next-coord (cons next-x next-y)))
            (if (set-member? visited next-coord)
                #t
                (loop next-x next-y (set-add visited next-coord) (cdr chars))))))))