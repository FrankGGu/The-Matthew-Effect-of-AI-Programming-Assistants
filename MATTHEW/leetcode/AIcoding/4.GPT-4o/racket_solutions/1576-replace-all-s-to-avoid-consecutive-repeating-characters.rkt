(define (modifyString s)
  (define (replace-char prev)
    (if (string-empty? s)
        ""
        (let ((current (string-ref s 0)))
          (if (equal? current #\?)
              (let loop ((c #\a))
                (if (or (equal? c prev) (equal? c (if (< (string-length s) 2) #\0 (string-ref s 1))))
                    (loop (integer->char (+ (char->integer c) 1)))
                    (begin
                      (set! s (string-append (string (if (< (string-length s) 1) #\0 (string-ref s 1))) (string c) (substring s 1)))
                      (replace-char c)))
              (begin
                (set! s (string-append (string current) (substring s 1)))
                (replace-char current))))))
  (replace-char #\0)
  s)

(modifyString "??yw?ippk??")