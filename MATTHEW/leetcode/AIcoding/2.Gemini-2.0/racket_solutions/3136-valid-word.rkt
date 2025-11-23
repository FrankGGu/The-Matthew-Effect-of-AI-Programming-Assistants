(define (valid-word? word dictionary)
  (define (helper word start)
    (cond
      [(equal? start (string-length word)) #t]
      [else
       (let loop ([i start])
         (cond
           [(>= i (string-length word)) #f]
           [(hash-ref dictionary (substring word start i) #f)
            (if (helper word i)
                #t
                (loop (+ i 1)))]
           [else (loop (+ i 1))]))]))
  (helper word 0))

(define (word-break s word-dict)
  (let* ([n (string-length s)]
         [word-set (make-hash)]
         [_ (for ([word (in-list word-dict)])
              (hash-set! word-set word #t))])
    (valid-word? s word-set)))