(define (create-data-frame columns data)
  (map (lambda (row)
         (for/fold ([row-hash (hash)])
                   ([col-name columns]
                    [value row])
           (hash-set row-hash col-name value)))
       data))