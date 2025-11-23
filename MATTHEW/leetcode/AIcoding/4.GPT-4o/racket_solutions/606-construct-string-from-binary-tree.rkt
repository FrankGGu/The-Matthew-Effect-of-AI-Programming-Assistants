(define (tree2str root)
  (if (null? root)
      ""
      (let ([left (tree2str (tree-left root))]
            [right (tree2str (tree-right root))])
        (if (and (null? left) (null? right))
            (number->string (tree-val root))
            (string-append (number->string (tree-val root))
                           (if (null? left) "" (string-append "(" left ")"))
                           (if (null? right) "" (string-append "(" right ")")))))))