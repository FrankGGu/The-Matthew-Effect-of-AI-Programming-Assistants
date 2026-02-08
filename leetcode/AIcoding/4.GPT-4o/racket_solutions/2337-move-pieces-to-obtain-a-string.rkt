(define (canTransform start end)
  (define (normalize s)
    (filter (lambda (c) (not (equal? c #\Space))) s))
  (define (move-characters s)
    (define (move-aux s index)
      (if (>= index (length s)) s
          (let* ((c (string-ref s index))
                 (next (move-aux s (+ index 1))))
            (cond ((equal? c #\L) (if (string-index next #\R) 
                                      (string-replace next #\L #\Space) 
                                      (string-replace next #\L #\L)))
                  ((equal? c #\R) (if (string-index next #\L) 
                                      (string-replace next #\R #\Space) 
                                      (string-replace next #\R #\R)))
                  (else next)))))
    (move-aux s 0))

  (define norm-start (normalize start))
  (define norm-end (normalize end))

  (if (not (equal? (length norm-start) (length norm-end))) 
      #f
      (let loop ((s (move-characters start))
                 (e (move-characters end)))
        (if (equal? s e) 
            #t 
            (loop (move-characters s) (move-characters e)))))))