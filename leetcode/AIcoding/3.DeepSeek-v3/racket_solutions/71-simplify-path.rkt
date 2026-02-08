(define (simplify-path path)
  (let* ((parts (filter (lambda (x) (not (or (string=? x ".") (string=? x ""))))
                        (string-split path "/")))
         (stack '()))
    (for-each (lambda (part)
                (cond
                  [(string=? part "..")
                   (when (not (null? stack))
                     (set! stack (cdr stack))]
                  [else (set! stack (cons part stack))]))
              parts)
    (string-append "/" (string-join (reverse stack) "/")))