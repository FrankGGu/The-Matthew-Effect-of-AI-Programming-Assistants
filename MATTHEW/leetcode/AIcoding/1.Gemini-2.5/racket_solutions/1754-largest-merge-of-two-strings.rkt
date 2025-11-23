(define (largest-merge word1 word2)
  (let loop ((idx1 0) (idx2 0) (result '()))
    (cond
      ((= idx1 (string-length word1))
       (string-append (list->string (reverse result)) (substring word2 idx2 (string-length word2))))
      ((= idx2 (string-length word2))
       (string-append (list->string (reverse result)) (substring word1 idx1 (string-length word1))))
      ((string>= (substring word1 idx1 (string-length word1))
                 (substring word2 idx2 (string-length word2)))
       (loop (+ idx1 1) idx2 (cons (string-ref word1 idx1) result)))
      (else
       (loop idx1 (+ idx2 1) (cons (string-ref word2 idx2) result))))))