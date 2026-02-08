(define (check-if-fascinating n)
  (let* ((s1 (number->string n))
         (s2 (number->string (* 2 n)))
         (s3 (number->string (* 3 n)))
         (combined-s (string-append s1 s2 s3)))
    (if (not (= (string-length combined-s) 9))
        #f
        (let ((seen-digits (make-vector 10 #f)))
          (for ([char (in-string combined-s)])
            (let ((digit (- (char->integer char) (char->integer #\0))))
              (when (= digit 0)
                (error 'check-if-fascinating "Digit 0 found")) ; This will be caught by the outer loop
              (when (vector-ref seen-digits digit)
                (error 'check-if-fascinating "Duplicate digit found")) ; This will be caught by the outer loop
              (vector-set! seen-digits digit #t))))
          ;; If we reach here, no 0s or duplicates were found by the error mechanism.
          ;; Now check if all digits 1-9 are present.
          (let loop ((i 1))
            (cond
              ((> i 9) #t)
              ((not (vector-ref seen-digits i)) #f)
              (else (loop (+ i 1)))))))))

(define (check-if-fascinating-v2 n)
  (let* ((s1 (number->string n))
         (s2 (number->string (* 2 n)))
         (s3 (number->string (* 3 n)))
         (combined-s (string-append s1 s2 s3)))
    (if (not (= (string-length combined-s) 9))
        #f
        (let ((seen-digits (make-vector 10 #f)))
          (let loop ((idx 0))
            (cond
              ((= idx (string-length combined-s))
               ;; All characters processed, now check if all 1-9 were seen
               (let loop-check ((i 1))
                 (cond
                   ((> i 9) #t)
                   ((not (vector-ref seen-digits i)) #f)
                   (else (loop-check (+ i 1))))))
              (else
               (let ((char (string-ref combined-s idx)))
                 (let ((digit (- (char->integer char) (char->integer #\0))))
                   (cond
                     ((= digit 0) #f) ; Contains 0
                     ((vector-ref seen-digits digit) #f) ; Duplicate digit
                     (else
                      (vector-set! seen-digits digit #t)
                      (loop (+ idx 1))))))))))))

(define (check-if-fascinating n)
  (let* ((s1 (number->string n))
         (s2 (number->string (* 2 n)))
         (s3 (number->string (* 3 n)))
         (combined-s (string-append s1 s2 s3)))
    (if (not (= (string-length combined-s) 9))
        #f
        (let* ((chars (string->list combined-s))
               (digits (map (lambda (c) (- (char->integer c) (char->integer #\0))) chars)))
          (if (member 0 digits)
              #f ; Contains 0
              (let ((sorted-digits (sort digits <)))
                (equal? sorted-digits '(1 2 3 4 5 6 7 8 9))))))))