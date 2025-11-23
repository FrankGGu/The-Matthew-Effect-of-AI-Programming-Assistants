(define (count-prefix-suffix-pairs words)
  (let ((n (length words)))
    (let loop ((i 0) (count 0))
      (if (= i n)
          count
          (loop (+ i 1)
                (let loop2 ((j (+ i 1)) (count2 count))
                  (if (= j n)
                      count2
                      (let ((word1 (list->string (list-ref words i)))
                            (word2 (list->string (list-ref words j))))
                        (if (and (string-prefix? word1 word2) (string-suffix? word1 word2))
                            (loop2 (+ j 1) (+ count2 1))
                            (loop2 (+ j 1) count2)))))))))