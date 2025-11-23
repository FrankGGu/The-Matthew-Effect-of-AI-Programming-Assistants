(require racket/string)

(define (largest-good-integer num)
  (let loop ((digit 9))
    (if (< digit 0)
        ""
        (let* ((char-digit (integer->char (+ (char->integer #\0) digit)))
               (target-str (string char-digit char-digit char-digit)))
          (if (string-contains? num target-str)
              target-str
              (loop (- digit 1)))))))