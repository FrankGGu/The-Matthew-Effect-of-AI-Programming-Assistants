(define (is-circular-sentence sentence)
  (let* ([words (string-split sentence)]
         [n (length words)])
    (if (zero? n)
        #t
        (and (char=? (string-ref (first words) 0)
                     (string-ref (last words) (sub1 (string-length (last words)))))
             (let loop ([i 0])
               (cond
                 [(>= i (sub1 n)) #t]
                 [else
                  (and (char=? (string-ref (list-ref words i) (sub1 (string-length (list-ref words i))))
                               (string-ref (list-ref words (add1 i)) 0))
                       (loop (add1 i)))]))))))