(define (get-length s i count)
  (if (>= i (string-length s))
      count
      (let* ((char (string-ref s i))
             (next (string-index s char i)))
        (if (and next (< next (string-length s)))
            (let ((next-char (string-ref s next)))
              (if (equal? char next-char)
                  (begin
                    (get-length s (add1 i) (add1 count)))
                  (get-length s (add1 next) (+ count 1))))
            (add1 count)))))

(define (compress s k)
  (define (dfs i count)
    (if (>= i (string-length s))
        count
        (let ((next (string-index s (string-ref s i) i)))
          (if (and next (< next (string-length s)))
              (let ((next-char (string-ref s next)))
                (if (equal? (string-ref s i) next-char)
                    (dfs (add1 i) count)
                    (let ((compress-count (get-length s i 0)))
                      (if (<= compress-count k)
                          (dfs (add1 next) (+ count (if (= compress-count 1) 1 (+ 1 (length (number->string compress-count))))))
                          (dfs (add1 i) count)))))
              (dfs (add1 i) count))))))

(define (compress-string s k)
  (dfs 0 0))

(define (compress-string-main s k)
  (compress-string s k))

(compress-string-main "aabbcc" 2)