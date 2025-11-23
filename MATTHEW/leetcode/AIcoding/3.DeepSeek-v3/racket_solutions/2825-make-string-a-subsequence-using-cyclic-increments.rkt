(define/contract (can-make-subsequence str target)
  (-> string? string? boolean?)
  (let loop ((i 0) (j 0))
    (if (>= j (string-length target))
        #t
        (if (>= i (string-length str))
            #f
            (let ((c1 (string-ref str i))
                  (c2 (string-ref target j)))
              (if (or (char=? c1 c2)
                      (char=? (integer->char (+ (modulo (+ (char->integer c1) 1 (- (char->integer #\a))) 26) (char->integer #\a))) c2))
                  (loop (+ i 1) (+ j 1))
                  (loop (+ i 1) j))))))