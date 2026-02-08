(define (seconds-to-remove-occurrences s)
  (let* ((n (string-length s)))
    (let loop ((idx 0)
               (zeros 0)
               (ans 0))
      (if (= idx n)
          ans
          (let ((char (string-ref s idx)))
            (if (char=? char #\0)
                (loop (+ idx 1) (+ zeros 1) ans)
                ;; char is #\1
                (if (> zeros 0)
                    (loop (+ idx 1) zeros (max (+ ans 1) zeros))
                    (loop (+ idx 1) zeros ans))))))))