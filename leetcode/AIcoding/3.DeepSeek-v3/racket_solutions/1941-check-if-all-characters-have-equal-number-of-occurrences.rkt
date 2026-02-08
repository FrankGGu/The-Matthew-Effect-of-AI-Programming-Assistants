(define/contract (are-occurrences-equal s)
  (-> string? boolean?)
  (let* ([counts (make-hash)]
         [len (string-length s)])
    (for ([i len])
      (let ([c (string-ref s i)])
        (hash-update! counts c add1 (lambda () 0))))
    (let ([vals (hash-values counts)])
      (if (null? vals)
          #t
          (let ([first-val (car vals)])
            (for/and ([val (cdr vals)])
              (= val first-val)))))))