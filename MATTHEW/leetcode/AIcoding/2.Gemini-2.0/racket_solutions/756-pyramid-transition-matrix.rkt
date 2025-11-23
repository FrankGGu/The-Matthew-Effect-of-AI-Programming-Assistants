(define (pyramidTransition bottom allowed)
  (define allowed-map
    (make-hash))
  (for ([a allowed])
    (let ([key (substring a 0 2)])
      (hash-update! allowed-map key (lambda (v) (cons (string-ref a 2) v)) '()))))

  (define (build-pyramid current)
    (if (= (string-length current) 1)
        #t
        (let ([next-level '()])
          (let loop ([i 0])
            (if (= i (- (string-length current) 1))
                (if (null? next-level)
                    #f
                    (build-pyramid (list->string next-level)))
                (let ([key (substring current i (+ i 2))])
                  (if (hash-has-key? allowed-map key)
                      (let ([allowed-chars (hash-ref allowed-map key)])
                        (let loop2 ([chars allowed-chars])
                          (if (null? chars)
                              #f
                              (begin
                                (set! next-level (append next-level (list (car chars))))
                                (if (build-pyramid (list->string next-level) ))
                                (set! next-level (drop-right next-level 1))
                                (loop2 (cdr chars)))))
                      #f)
                  (begin (loop (+ i 1))))))))

  (build-pyramid bottom))