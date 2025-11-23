(define (max-diff-by-remapping-a-digit num)
  (let* ((s (number->string num)))

    (define (replace-all-chars str old-char new-char)
      (list->string
       (map (lambda (c) (if (char=? c old-char) new-char c))
            (string->list str))))

    (let* ((first-non-9-char
            (let loop ((i 0))
              (cond
                ((= i (string-length s)) #f)
                ((not (char=? (stringref s i) #\9)) (stringref s i))
                (else (loop (+ i 1))))))
           (max-s (if first-non-9-char
                      (replace-all-chars s first-non-9-char #\9)
                      s))
           (max-val (string->number max-s)))

      (let* ((first-char (stringref s 0))
             (min-s (replace-all-chars s first-char #\0))
             (min-val (string->number min-s)))

        (- max-val min-val)))))