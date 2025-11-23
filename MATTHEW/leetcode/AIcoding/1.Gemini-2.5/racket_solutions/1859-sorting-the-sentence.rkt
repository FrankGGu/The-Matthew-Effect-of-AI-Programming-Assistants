(define (sort-sentence s)
  (let* ([words (string-split s)]
         [num-words (length words)]
         [result-vec (make-vector num-words)])
    (for-each
     (lambda (word)
       (let* ([word-len (string-length word)]
              [last-char (string-ref word (sub1 word-len))]
              [pos (string->number (string last-char))]
              [actual-word (substring word 0 (sub1 word-len))])
         (vector-set! result-vec (sub1 pos) actual-word)))
     words)
    (string-join (vector->list result-vec) " ")))