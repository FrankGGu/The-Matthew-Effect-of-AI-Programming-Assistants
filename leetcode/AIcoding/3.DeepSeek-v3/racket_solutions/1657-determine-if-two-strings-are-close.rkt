(define/contract (close-strings word1 word2)
  (-> string? string? boolean?)
  (let* ([count1 (make-hash)]
         [count2 (make-hash)]
         [chars1 (string->list word1)]
         [chars2 (string->list word2)]
         [freq1 (for/list ([c chars1]) (hash-update! count1 c add1 0))]
         [freq2 (for/list ([c chars2]) (hash-update! count2 c add1 0))])
    (and (equal? (hash-keys count1) (hash-keys count2))
         (equal? (sort (hash-values count1) <) (sort (hash-values count2) <))))