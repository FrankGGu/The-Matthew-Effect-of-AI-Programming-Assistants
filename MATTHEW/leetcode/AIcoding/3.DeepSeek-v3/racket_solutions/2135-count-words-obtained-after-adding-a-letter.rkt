(define (word-count start-words target-words)
  (define start-sets
    (for/set ([word start-words])
      (list->set (string->list word))))

  (define count 0)

  (for ([target target-words])
    (define target-chars (string->list target))
    (define target-len (length target-chars))
    (define found #f)

    (for ([i (in-range target-len)] #:break found)
      (define candidate-chars (list-remove target-chars i))
      (define candidate-set (list->set candidate-chars))
      (when (set-member? start-sets candidate-set)
        (set! count (add1 count))
        (set! found #t))))

  count)

(define (list-remove lst i)
  (append (take lst i) (drop lst (add1 i))))