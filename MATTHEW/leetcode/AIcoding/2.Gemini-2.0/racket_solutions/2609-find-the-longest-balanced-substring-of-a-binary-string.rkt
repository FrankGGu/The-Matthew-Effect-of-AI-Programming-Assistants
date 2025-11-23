(define (find-the-longest-balanced-substring s)
  (let* ([n (string-length s)]
         [max-len 0])
    (for ([i (in-range n)])
      (for ([j (in-range (+ i 1) (+ n 1))])
        (let* ([sub (substring s i j)]
               [len (string-length sub)]
               [zeros (count #\0 sub)]
               [ones (count #\1 sub)])
          (when (and (= zeros ones) (> len max-len))
            (set! max-len len)))))
    max-len))