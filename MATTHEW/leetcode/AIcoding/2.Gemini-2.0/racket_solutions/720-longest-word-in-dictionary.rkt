(define (longest-word dictionary)
  (let* ((word-set (set dictionary))
         (sorted-words (sort dictionary string<?))
         (longest ""))
    (for ([word (in-list sorted-words)])
      (let loop ([i 1])
        (cond
          [(>= i (string-length word))
           (if (> (string-length word) (string-length longest))
               (set! longest word))]
          [(set-member? word-set (substring word 0 i))
           (loop (+ i 1))]
          [else #f])))
    longest))