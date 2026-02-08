(define/contract (similar-pairs words)
  (-> (listof string?) exact-integer?)
  (define (get-signature word)
    (list->set (string->list word)))
  (let loop ([words words] [count 0] [seen (hash)])
    (if (null? words)
        count
        (let* ([word (car words)]
               [sig (get-signature word)]
               [sig-list (sort (set->list sig) char<?)]
               [sig-key (list->string sig-list)]
               [prev-count (hash-ref seen sig-key 0)])
          (loop (cdr words) 
                (+ count prev-count) 
                (hash-set seen sig-key (add1 prev-count)))))))