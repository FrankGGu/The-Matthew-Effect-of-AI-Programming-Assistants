(define (word-pattern pattern s)
  (let* ([words (string-split s)]
         [pattern-len (string-length pattern)]
         [words-len (length words)])
    (if (not (= pattern-len words-len))
        #f
        (let ([p-to-w (make-hash)]
              [w-to-p (make-hash)])
          (let loop ([i 0])
            (if (= i pattern-len)
                #t
                (let* ([p (string (string-ref pattern i))]
                       [w (list-ref words i)]
                       [p-val (hash-ref p-to-w p #f)]
                       [w-val (hash-ref w-to-p w #f)])
                  (cond
                    [(and p-val w-val)
                     (and (equal? p-val w) (equal? w-val p))
                     ]
                    [(or p-val w-val) #f]
                    [else
                     (begin
                       (hash-set! p-to-w p w)
                       (hash-set! w-to-p w p)
                       (loop (+ i 1)))]))))))))