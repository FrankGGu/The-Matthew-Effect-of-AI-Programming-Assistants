(define (remove-duplicates s k)
  (let loop ((chars (string->list s))
             (stack '())) ; stack stores (char . count) pairs
    (if (null? chars)
        ;; End of string, build result from stack
        (list->string
         (apply append
                (map (lambda (pair)
                       (let ((char (car pair))
                             (count (cdr pair)))
                         (make-list count char)))
                     (reverse stack))))
        ;; Process current character
        (let* ((current-char (car chars))
               (rest-chars (cdr chars)))
          (if (and (not (null? stack))
                   (char=? current-char (caar stack)))
              ;; Current char matches top of stack
              (let* ((top-pair (car stack))
                     (top-char (car top-pair))
                     (top-count (cdr top-pair))
                     (new-count (+ top-count 1)))
                (if (= new-count k)
                    ;; Count reaches k, pop the element (don't push back)
                    (loop rest-chars (cdr stack))
                    ;; Count less than k, update count and push back
                    (loop rest-chars (cons (cons top-char new-count) (cdr stack)))))
              ;; Current char is different from top of stack or stack is empty
              (loop rest-chars (cons (cons current-char 1) stack)))))))