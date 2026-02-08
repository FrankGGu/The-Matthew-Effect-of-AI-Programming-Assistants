(define (decode-message key message)
  (let* ([key (string-replace key " " "")]
         [unique-chars (remove-duplicates (string->list key))]
         [substitution (make-hash)]
         [current-char #\a])
    (for ([ch unique-chars] [i (in-range 26)])
      (hash-set! substitution ch current-char)
      (set! current-char (integer->char (+ (char->integer current-char) 1)))
    (list->string
     (for/list ([ch message])
       (if (char=? ch #\space)
           #\space
           (hash-ref substitution ch))))))