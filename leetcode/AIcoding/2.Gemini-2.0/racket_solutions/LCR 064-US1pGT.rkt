(define buildDict
  (lambda (dictionary)
    (struct dict (word len) #:transparent)
    (define dict-list (map (lambda (w) (dict w (string-length w))) dictionary))
    (define dict-hash (make-hash))
    (for-each (lambda (d)
                (hash-set! dict-hash (dict-len d) (append (hash-ref dict-hash (dict-len d) '()) (list (dict-word d)))))
              dict-list)
    dict-hash))

(define search
  (lambda (word dict)
    (define len (string-length word))
    (if (not (hash-has-key? dict len))
        #f
        (let ([words (hash-ref dict len)])
          (ormap (lambda (w)
                   (let loop ([i 0] [diff 0])
                     (cond
                       [(= i len) (if (= diff 1) #t #f)]
                       [(= diff 2) #f]
                       [else (if (string=? (substring word i (+ i 1)) (substring w i (+ i 1)))
                                 (loop (+ i 1) diff)
                                 (loop (+ i 1) (+ diff 1)))])))
                 words)))))