(define (fullJustify words maxWidth)
  (define (addSpaces line spaces)
    (if (null? line)
        '()
        (let* ((n (length line))
               (space (if (= n 1) 0 (quotient spaces (- n 1))))
               (extra (if (= n 1) 0 (remainder spaces (- n 1)))))
          (if (null? (cdr line))
              (cons (string-append (car line) (make-string (- maxWidth (string-length (car line))) #\space)) '())
              (cons (string-append (car line) (make-string (1+ space) #\space))
                    (addSpaces (cdr line) (if (zero? extra) space (sub1 space)))))))))

  (define (justify lines)
    (map (lambda (line)
           (let ((total-length (foldl (lambda (acc word) (+ acc (string-length word))) 0 line)))
             (if (= (length line) 1)
                 (string-append (car line) (make-string (- maxWidth total-length) #\space))
                 (string-append (apply string-append (addSpaces line (- maxWidth total-length))) ""))))
         lines))

  (define (helper words acc current-line current-length)
    (cond
      ((null? words)
       (if (null? current-line)
           acc
           (append acc (list (string-append (apply string-append current-line) (make-string (- maxWidth current-length) #\space))))))
      ((> (+ current-length (string-length (car words))) maxWidth)
       (helper (cdr words) (append acc (list (string-append (apply string-append (addSpaces current-line (- maxWidth current-length))) ""))) '() 0))
      (else
       (helper (cdr words) acc (cons (car words) current-line) (+ current-length (string-length (car words)))))))

  (justify (helper words '() '() 0)))

(fullJustify '("This", "is", "an", "example", "of", "text", "justification.") 16)