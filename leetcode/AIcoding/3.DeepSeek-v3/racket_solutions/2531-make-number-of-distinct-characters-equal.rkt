(define (is-it-possible word1 word2)
  (define (count-distinct s)
    (hash-count (for/fold ([h (hash)]) ([c (in-string s)])
                  (hash-update h c add1 0))))
  (define (can-make-equal? word1 word2)
    (define c1 (count-distinct word1))
    (define c2 (count-distinct word2))
    (define diff (abs (- c1 c2)))
    (cond
      [(= c1 c2) #t]
      [(> diff 2) #f]
      [else
       (define freq1 (make-hash))
       (define freq2 (make-hash))
       (for ([c (in-string word1)]) (hash-update! freq1 c add1 0))
       (for ([c (in-string word2)]) (hash-update! freq2 c add1 0))
       (define keys1 (hash-keys freq1))
       (define keys2 (hash-keys freq2))
       (define (check a b)
         (for*/or ([x (in-list a)]
                   [y (in-list b)])
           (let* ([new-freq1 (hash-copy freq1)]
                  [new-freq2 (hash-copy freq2)]
                  [count1 (hash-ref new-freq1 x)]
                  [count2 (hash-ref new-freq2 y)])
             (hash-update! new-freq1 x sub1)
             (when (= (hash-ref new-freq1 x) 0) (hash-remove! new-freq1 x))
             (hash-update! new-freq2 x add1)
             (hash-update! new-freq2 y sub1)
             (when (= (hash-ref new-freq2 y) 0) (hash-remove! new-freq2 y))
             (hash-update! new-freq1 y add1)
             (= (hash-count new-freq1) (hash-count new-freq2)))))
       (or (check keys1 keys2) (check keys2 keys1))]))
  (can-make-equal? word1 word2))