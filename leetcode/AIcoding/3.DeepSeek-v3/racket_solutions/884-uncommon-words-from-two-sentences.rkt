(define (uncommon-from-sentences s1 s2)
  (define (count-words s)
    (let loop ([words (string-split s)] [counts (hash)])
      (if (null? words)
          counts
          (let ([word (car words)])
            (loop (cdr words) (hash-set counts word (add1 (hash-ref counts word 0))))))))

  (let* ([counts1 (count-words s1)]
         [counts2 (count-words s2)]
         [all-counts (for/fold ([result counts1])
                               ([(word cnt) counts2])
                       (hash-set result word (+ cnt (hash-ref result word 0))))]
    (for/list ([(word cnt) all-counts]
               #:when (= cnt 1))
      word)))