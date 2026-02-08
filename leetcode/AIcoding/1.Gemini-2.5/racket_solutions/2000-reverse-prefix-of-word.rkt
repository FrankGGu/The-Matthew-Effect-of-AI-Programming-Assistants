(define (reverse-prefix word ch)
  (let* ((len (string-length word))
         (idx (string-index word ch)))
    (if idx
        (let* ((prefix-str (substring word 0 (+ idx 1)))
               (suffix-str (substring word (+ idx 1) len))
               (reversed-prefix-list (reverse (string->list prefix-str))))
          (string-append (list->string reversed-prefix-list) suffix-str))
        word)))