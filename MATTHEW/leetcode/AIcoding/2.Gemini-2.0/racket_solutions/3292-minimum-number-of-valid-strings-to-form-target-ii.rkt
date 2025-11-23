(define (min-valid-strings target words)
  (define (solve target words memo)
    (cond
      [(hash-has-key? memo target) (hash-ref memo target)]
      [(string=? target "") 0]
      [else
       (let loop ([i 0] [min-count #f])
         (cond
           [(= i (length words))
            (if min-count
                min-count
                #f)]
           [else
            (let ([word (list-ref words i)])
              (let ([idx (string-contains target word)])
                (if idx
                    (let ([remaining (string-append (substring target 0 idx) (substring target (+ idx (string-length word)) (string-length target)))])
                      (let ([sub-result (solve remaining words memo)])
                        (if sub-result
                            (let ([count (+ 1 sub-result)])
                              (loop (+ i 1) (if (or (not min-count) (< count min-count)) count min-count)))
                            (loop (+ i 1) min-count))))
                    (loop (+ i 1) min-count))))))]))
       (let ([result (solve target words (make-hash))])
         (if result
             (begin
               (hash-set! memo target result)
               result)
             #f))]))
  (let ([result (solve target words (make-hash))])
    (if result result -1)))