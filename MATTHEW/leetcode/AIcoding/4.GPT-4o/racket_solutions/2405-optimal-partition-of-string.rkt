(define (partition-string s)
  (define (helper s seen count)
    (if (null? s)
        count
        (let ((char (car s)))
          (if (member char seen)
              (helper (cdr s) (list char) (+ count 1))
              (helper (cdr s) (cons char seen) count)))))
  (helper (string->list s) '() 0))

(partition-string "abacaba")