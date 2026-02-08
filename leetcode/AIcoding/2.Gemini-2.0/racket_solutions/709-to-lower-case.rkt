(define (to-lower-case s)
  (list->string
   (map (lambda (c)
          (let ((code (char->integer c)))
            (if (and (>= code 65) (<= code 90))
                (integer->char (+ code 32))
                c)))
        (string->list s))))