(define (is-match s p)
  (let* ((n (string-length s))
         (m (string-length p))
         (memo (make-hash)))

    (define (dp s-idx p-idx)
      (let ((key (cons s-idx p-idx)))
        (cond
          ((hash-has-key? memo key) (hash-ref memo key))
          (else
           (let ((result
                   (cond
                     ;; Base case 1: Pattern exhausted
                     ((= p-idx m) (= s-idx n))

                     ;; Base case 2: String exhausted (and pattern not)
                     ((= s-idx n)
                      ;; Check if remaining pattern characters are all '*'
                      (let loop ((k p-idx))
                        (cond
                          ((= k m) #t)
                          ((char=? #\* (string-ref p k)) (loop (+ k 1)))
                          (else #f))))

                     ;; Recursive step
                     (else
                      (let ((p-char (string-ref p p-idx)))
                        (cond
                          ;; Case 1: Current pattern char is '?'
                          ((char=? p-char #\?)
                           (dp (+ s-idx 1) (+ p-idx 1)))

                          ;; Case 2: Current pattern char is '*'
                          ((char=? p-char #\*)
                           ;; '*' matches empty string OR '*' matches current s-char and continues
                           (or (dp s-idx (+ p-idx 1))  ; '*' matches empty
                               (dp (+ s-idx 1) p-idx))) ; '*' matches s-char

                          ;; Case 3: Current pattern char is a regular character
                          (else
                           (and (char=? (string-ref s s-idx) p-char)
                                (dp (+ s-idx 1) (+ p-idx 1))))))))))
             (hash-set! memo key result)
             result))))

    (dp 0 0)))