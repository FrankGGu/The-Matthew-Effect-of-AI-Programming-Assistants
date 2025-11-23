(define (is-scramble s1 s2)
  (let ((n1 (string-length s1))
        (n2 (string-length s2)))

    (unless (= n1 n2)
      #f)
    (when (= n1 0) #t)

    (let ((char-counts1 (make-hash))
          (char-counts2 (make-hash)))
      (for-each (lambda (c) (hash-update! char-counts1 c add1 0)) (string->list s1))
      (for-each (lambda (c) (hash-update! char-counts2 c add1 0)) (string->list s2))
      (unless (hash-equal? char-counts1 char-counts2)
        #f)

      (let ((memo (make-hash)))

        (define (helper str1 str2)
          (let ((len (string-length str1)))
            (cond
              ((string=? str1 str2) #t)
              ((= len 1) #f)
              (else
               (let ((key (cons str1 str2)))
                 (case (hash-ref memo key #f)
                   ((#f)
                    (let loop ((i 1) (found #f))
                      (cond
                        (found #t)
                        ((>= i len) #f)
                        (else
                         (let* ((s1-left (substring str1 0 i))
                                (s1-right (substring str1 i len))
                                (s2-left (substring str2 0 i))
                                (s2-right (substring str2 i len))
                                (s2-swapped-left (substring str2 (- len i) len))
                                (s2-swapped-right (substring str2 0 (- len i))))
                           (if (or (and (helper s1-left s2-left) (helper s1-right s2-right))
                                   (and (helper s1-left s2-swapped-left) (helper s1-right s2-swapped-right)))
                               (begin
                                 (hash-set! memo key #t)
                                 #t)
                               (loop (+ i 1) #f))))))))
                   (result result)))))))

        (helper s1 s2)))))