(define (lexical-order n)
  (letrec ((helper (lambda (curr acc)
                     (if (> curr n)
                         acc
                         (let loop ((i 0))
                           (cond
                             ((= i 10) acc)
                             ((<= curr n)
                              (loop (+ i 1)))
                             (else
                              (cons curr (helper (* curr 10) acc))))))))
            (build-list (lambda (n f)
                          (let loop ((i 1) (acc '()))
                            (if (> i n)
                                (reverse acc)
                                (loop (+ i 1) (cons (f i) acc)))))))
    (build-list n (lambda (i) i))
    (reverse (helper 1 '()))))