(define (get-folder-names names)
  (let loop ([names names]
             [seen (hash)]
             [result '()])
    (if (null? names)
        (reverse result)
        (let* ([name (car names)]
               [count (hash-ref seen name 0)]
               [new-name (if (= count 0)
                             name
                             (format "~a(~a)" name count))]
               [new-count (if (hash-has-key? seen new-name)
                             (hash-ref seen new-name)
                             (hash-ref seen name 0))])
          (loop (cdr names)
                (hash-set (hash-set seen name (+ count 1)) new-name (+ new-count 1))
                (cons new-name result))))))