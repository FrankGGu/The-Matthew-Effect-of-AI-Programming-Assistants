(define (pyramid-transition bottom allowed)
  (let ((allowed-table (make-hash)))
    (for ([triple allowed])
      (let ((key (substring triple 0 2))
            (value (substring triple 2 3)))
        (hash-set! allowed-table key 
                   (cons value (hash-ref allowed-table key '())))))

    (define (dfs current next level)
      (if (= (string-length current) 1)
          #t
          (if (= (string-length next) (- (string-length current) 1))
              (dfs next "" 0)
              (let* ((key (substring current level (+ level 2)))
                     (values (hash-ref allowed-table key '())))
                (if (null? values)
                    #f
                    (ormap (lambda (v) 
                             (dfs current (string-append next v) (+ level 1)))
                           values))))))

    (dfs bottom "" 0))