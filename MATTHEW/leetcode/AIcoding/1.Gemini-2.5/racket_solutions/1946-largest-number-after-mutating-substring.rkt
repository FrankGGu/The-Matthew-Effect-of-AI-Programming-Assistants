(define (largest-number-after-mutating-substring num change)
  (let* ((num-chars (string->list num))
         (change-vec (list->vector change))
         (char-0-int (char->integer #\0)))

    (define (helper current-num-chars
                    acc-chars
                    found-start-mutation
                    finished-mutation)
      (cond
        ((null? current-num-chars)
         (list->string (reverse acc-chars)))

        (else
         (let* ((current-char (car current-num-chars))
                (d (- (char->integer current-char) char-0-int))
                (cd (vector-ref change-vec d)))

           (cond
             ((true? finished-mutation)
              (helper (cdr current-num-chars)
                      (cons current-char acc-chars)
                      found-start-mutation
                      finished-mutation))

             ((true? found-start-mutation)
              (if (>= cd d)
                  (helper (cdr current-num-chars)
                          (cons (integer->char (+ char-0-int cd)) acc-chars)
                          found-start-mutation
                          finished-mutation)
                  (helper (cdr current-num-chars)
                          (cons current-char acc-chars)
                          found-start-mutation
                          #t)))

             (else
              (if (> cd d)
                  (helper (cdr current-num-chars)
                          (cons (integer->char (+ char-0-int cd)) acc-chars)
                          #t
                          finished-mutation)
                  (helper (cdr current-num-chars)
                          (cons current-char acc-chars)
                          found-start-mutation
                          finished-mutation)))))))

    (helper num-chars '() #f #f)))