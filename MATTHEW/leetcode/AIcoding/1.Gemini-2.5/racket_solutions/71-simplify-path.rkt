(define (simplify-path path)
  (let* ([components (string-split path "/")]
         [stack (foldl (lambda (component acc)
                         (cond
                           [(or (string=? component "")
                                (string=? component "."))
                            acc]
                           [(string=? component "..")
                            (if (empty? acc)
                                acc
                                (rest acc))]
                           [else
                            (cons component acc)]))
                       '()
                       components)])
    (if (empty? stack)
        "/"
        (string-append "/" (string-join (reverse stack) "/")))))