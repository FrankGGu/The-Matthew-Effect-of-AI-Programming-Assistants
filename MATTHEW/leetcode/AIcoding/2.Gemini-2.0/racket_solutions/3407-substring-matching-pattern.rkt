(define (substring-matching-pattern pattern string)
  (let* ((pattern-length (string-length pattern))
         (string-length (string-length string))
         (pattern-map (make-hash))
         (string-set (make-hash))
         (pattern-string-list (string->list pattern)))
    (define (match-helper string-index pattern-index)
      (cond
        [(= pattern-index pattern-length) (= string-index string-length)]
        [(= string-index string-length) #f]
        [else
         (let* ((pattern-char (list->string (list (list-ref pattern-string-list pattern-index))))
                (pattern-char-exists? (hash-has-key? pattern-map pattern-char)))
           (cond
             [pattern-char-exists?
              (let ((mapped-string (hash-ref pattern-map pattern-char)))
                (and (string=? (substring string string-index (+ string-index (string-length mapped-string))) mapped-string)
                     (match-helper (+ string-index (string-length mapped-string)) (+ pattern-index 1))))]
             [else
              (for/or ([i (in-range 1 (- string-length string-index (+ 1)))] #:break (hash-has-key? string-set (substring string string-index (+ string-index i))))
                (let ((current-substring (substring string string-index (+ string-index i))))
                  (unless (hash-has-key? string-set current-substring)
                    (hash-set! pattern-map pattern-char current-substring)
                    (hash-set! string-set current-substring #t)
                    (if (match-helper (+ string-index i) (+ pattern-index 1))
                        #t
                        (begin
                          (hash-remove! pattern-map pattern-char)
                          (hash-remove! string-set current-substring)
                          #f)))))])))]))
    (hash-clear! pattern-map)
    (hash-clear! string-set)
    (match-helper 0 0)))