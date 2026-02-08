(define (replace-words dictionary sentence)
  (let* ([dict-set (list->set dictionary)]
         [words (string-split sentence)])
    (string-join
     (map (lambda (word)
            (let loop ([i 1])
              (if (> i (string-length word))
                  word
                  (let ([prefix (substring word 0 i)])
                    (if (set-member? dict-set prefix)
                        prefix
                        (loop (add1 i)))))))
          words)
     " ")))