(define (remove-comments source)
  (let loop ((lines source)
             (in-block-comment? #f)
             (current-line-buffer (string-builder))
             (result '()))

    (if (empty? lines)
        (reverse result)
        (let* ((line (car lines))
               (line-len (string-length line)))
          (let loop-char ((idx 0))
            (if (>= idx line-len)
                (begin
                  (when (and (not in-block-comment?)
                             (> (string-builder-length current-line-buffer) 0))
                    (set! result (cons (string-builder->string current-line-buffer) result)))
                  (when (not in-block-comment?)
                    (string-builder-clear! current-line-buffer))
                  (loop (cdr lines) in-block-comment? current-line-buffer result))

                (let ((char1 (string-ref line idx))
                      (char2 (if (< (+ idx 1) line-len)
                                 (string-ref line (+ idx 1))
                                 #\nul)))

                  (cond
                    (in-block-comment?
                     (if (and (char=? char1 #\*) (char=? char2 #\/))
                         (begin
                           (set! in-block-comment? #f)
                           (loop-char (+ idx 2)))
                         (loop-char (+ idx 1))))

                    (else
                     (cond
                       ((and (char=? char1 #\/) (char=? char2 #\/))
                        (loop-char line-len))

                       ((and (char=? char1 #\/) (char=? char2 #\*))
                        (set! in-block-comment? #t)
                        (loop-char (+ idx 2)))

                       (else
                        (string-builder-add! current-line-buffer char1)
                        (loop-char (+ idx 1)))))))))))
  )