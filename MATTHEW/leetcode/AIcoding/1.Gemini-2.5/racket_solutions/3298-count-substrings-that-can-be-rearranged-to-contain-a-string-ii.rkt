(define (count-substrings-that-can-be-rearranged-to-contain-a-string-ii s)
  (let* ([n (string-length s)])
    (let loop ([j 0]
               [last-a -1]
               [last-b -1]
               [last-c -1]
               [total-count 0])
      (if (= j n)
          total-count
          (let* ([char (string-ref s j)]
                 [new-last-a (if (char=? char #\a) j last-a)]
                 [new-last-b (if (char=? char #\b) j last-b)]
                 [new-last-c (if (char=? char #\c) j last-c)]
                 [current-add (if (and (>= new-last-a 0)
                                        (>= new-last-b 0)
                                        (>= new-last-c 0))
                                  (+ 1 (min new-last-a new-last-b new-last-c))
                                  0)])
            (loop (+ j 1)
                  new-last-a
                  new-last-b
                  new-last-c
                  (+ total-count current-add)))))))