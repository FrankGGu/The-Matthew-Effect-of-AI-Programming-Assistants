(define/contract (find-and-replace-pattern words pattern)
  (-> (listof string?) string? (listof string?))
  (define (match-pattern? word pattern)
    (let loop ([w (string->list word)]
               [p (string->list pattern)]
               [w-to-p (make-hash)]
               [p-to-w (make-hash)])
      (cond
        [(and (null? w) (null? p)) #t]
        [(or (null? w) (null? p)) #f]
        [else
         (let ([wc (car w)]
               [pc (car p)])
           (cond
             [(and (hash-has-key? w-to-p wc) (hash-has-key? p-to-w pc))
              (if (and (equal? (hash-ref w-to-p wc) pc) (equal? (hash-ref p-to-w pc) wc))
                  (loop (cdr w) (cdr p) w-to-p p-to-w)
                  #f)]
             [(or (hash-has-key? w-to-p wc) (hash-has-key? p-to-w pc)) #f]
             [else
              (hash-set! w-to-p wc pc)
              (hash-set! p-to-w pc wc)
              (loop (cdr w) (cdr p) w-to-p p-to-w)]))])))
  (filter (lambda (word) (match-pattern? word pattern)) words))