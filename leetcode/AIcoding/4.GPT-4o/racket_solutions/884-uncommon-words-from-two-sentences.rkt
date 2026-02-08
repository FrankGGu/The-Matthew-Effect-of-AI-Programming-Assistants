(define (uncommon-from-sentences A B)
  (define (count-words words)
    (for/fold ([counts (make-hash)])
               ([word (string-split words)])
      (hash-update! counts word (lambda (v) (+ v 1)) 1)))

  (define countA (count-words A))
  (define countB (count-words B))

  (define (filter-uncommon counts)
    (for/list ([entry (hash->list counts)]
               #:when (= (cdr entry) 1))
      (car entry)))

  (append (filter-uncommon countA) (filter-uncommon countB)))

(uncommon-from-sentences "this apple is sweet" "this apple is sour")