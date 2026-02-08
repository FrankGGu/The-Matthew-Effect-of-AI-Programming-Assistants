(define/contract (max-num-of-substrings s)
  (-> string? (listof string?))
  (let* ([n (string-length s)]
         [first-pos (make-hash)]
         [last-pos (make-hash)]
         [result '()])
    (for ([i (in-range n)])
      (let ([c (string-ref s i)])
        (unless (hash-has-key? first-pos c)
          (hash-set! first-pos c i))
        (hash-set! last-pos c i)))
    (let loop ([i 0])
      (when (< i n)
        (let ([c (string-ref s i)])
          (let ([start (hash-ref first-pos c)]
                [end (hash-ref last-pos c)])
            (let ([j start])
              (let/ec break
                (while (<= j end)
                  (let ([c2 (string-ref s j)])
                    (when (< (hash-ref first-pos c2) start)
                      (break))
                    (set! end (max end (hash-ref last-pos c2)))
                    (set! j (+ j 1)))))
              (if (= j (+ end 1))
                  (begin
                    (set! result (cons (substring s start (+ end 1)) result))
                    (loop (+ end 1)))
                  (loop (+ i 1)))))))
    (reverse result)))