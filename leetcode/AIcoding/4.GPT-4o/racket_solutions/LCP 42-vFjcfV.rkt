(define (play-toy-circles toys)
  (define (helper toys seen)
    (if (null? toys)
        0
        (let ((current (car toys)))
          (if (member current seen)
              (helper (cdr toys) seen)
              (+ 1 (helper (cdr toys) (cons current seen)))))))
  (helper toys '()))

(play-toy-circles '(2 3 2 4 3 1 5 1))