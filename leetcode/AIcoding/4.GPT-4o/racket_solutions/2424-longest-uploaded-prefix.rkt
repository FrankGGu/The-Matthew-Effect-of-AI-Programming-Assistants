(define (longestUploadedPrefix logs)
  (define prefix-length 0)
  (define total-length (length logs))
  (define (helper index)
    (if (or (= index total-length) (= (string-length (list-ref logs index)) 0))
        prefix-length
        (begin
          (set! prefix-length (+ prefix-length 1))
          (helper (+ index 1)))))
  (helper 0))

(longestUploadedPrefix '("a" "b" "c" "d" "e"))