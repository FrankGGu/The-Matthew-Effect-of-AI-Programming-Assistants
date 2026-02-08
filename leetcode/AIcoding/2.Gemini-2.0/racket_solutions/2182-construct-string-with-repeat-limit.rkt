(define (repeat-limited-string s repeat-limit)
  (define counts (make-hash))
  (for ([c (string->list s)])
    (hash-update! counts c (lambda (v) (+ v 1)) 0))

  (define sorted-chars (sort (hash-keys counts) >))

  (define result "")

  (let loop ([remaining-chars sorted-chars])
    (cond
      [(empty? remaining-chars) result]
      [else
       (let* ([c (car remaining-chars)]
              [count (hash-ref counts c)])
         (cond
           [(zero? count)
            (loop (cdr remaining-chars))]
           [else
            (let* ([repeat-count (min count repeat-limit)])
              (set! result (string-append result (list->string (make-list repeat-count c))))
              (hash-update! counts c (lambda (v) (- v repeat-count)) 0)
              (if (= repeat-count count)
                  (loop (cdr remaining-chars))
                  (let loop2 ([remaining-chars2 (cdr remaining-chars)])
                    (cond
                      [(empty? remaining-chars2) result]
                      [else
                       (let ([c2 (car remaining-chars2)]
                             [count2 (hash-ref counts c2)])
                         (cond
                           [(zero? count2)
                            (loop2 (cdr remaining-chars2))]
                           [else
                            (set! result (string-append result (list->string (list c2))))
                            (hash-update! counts c2 (lambda (v) (- v 1)) 0)
                            (loop (cons c (append (remove* (list c2) (cdr remaining-chars)) (list c2)))))])))])))))])))]))
  result)