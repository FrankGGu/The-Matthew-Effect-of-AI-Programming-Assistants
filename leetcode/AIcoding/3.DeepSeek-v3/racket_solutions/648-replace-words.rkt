(define (replace-words dict sentence)
  (let* ([dict-set (list->set dict)]
         [words (string-split sentence)])
    (string-join
     (for/list ([word words])
       (let loop ([i 1])
         (let ([prefix (substring word 0 i)])
           (cond
             [(> i (string-length word)) word]
             [(set-member? dict-set prefix) prefix]
             [else (loop (add1 i))]))))
     " ")))